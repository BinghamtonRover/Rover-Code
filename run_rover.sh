#!/usr/bin/env bash
# Runs the two ROS2 rover programs: subsystems and video.
#
# Usage:
#   ./run_rover.sh          # start both programs
#   ./run_rover.sh stop     # stop both programs
#   ./run_rover.sh status   # show what's running
#   ./run_rover.sh restart  # stop then start
#   ./run_rover.sh pi build # compile the video program for the Pi Zero 2 W
#   ./run_rover.sh pi start # stream the Pi cameras straight to the Dashboard
#   ./run_rover.sh pi stop | status | restart
#
# Pi Zero 2 W mode (`pi`):
# - Builds video_ros2 (and subsystems_ros2) with RealSense support explicitly
#   disabled and low build parallelism so the 512 MB board does not OOM.
# - Starts ONLY the video program, serving the BURT dashboard protocol
#   directly on UDP :8002 (video_pi.launch.py). There is no central video
#   streamer: every Pi Zero 2 W streams its own cameras to the Dashboard, and
#   the Dashboard connects to each board independently.
#
# Portability:
# - Works from any directory and with any colcon workspace name/location.
#   Workspace resolution order: $ROVER_WS, then the directory containing this
#   script (if it has install/setup.bash), then ~/rover_ws, then the first
#   ~/..._ws with install/setup.bash.
# - Uses whatever ROS2 distro is installed (first one found under /opt/ros).
# - Starts the autonomy node alongside the subsystems and video programs.

# Note: deliberately no `set -u` -- the ROS setup scripts reference unbound variables.
set -o pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------------------------------------------------------------------
# Locate a ROS2 installation (e.g. /opt/ros/humble). Uses the newest distro
# found, or honors $ROS_DISTRO if it is already set.
# ---------------------------------------------------------------------------
find_ros_distro() {
  if [[ -n "$ROS_DISTRO" && -f "/opt/ros/$ROS_DISTRO/setup.bash" ]]; then
    echo "/opt/ros/$ROS_DISTRO"
    return 0
  fi
  local dir distro
  for dir in /opt/ros/*/; do
    [[ -f "$dir/setup.bash" ]] || continue
    distro="$(basename "$dir")"
  done
  if [[ -n "$distro" ]]; then
    echo "/opt/ros/$distro"
  fi
}

# ---------------------------------------------------------------------------
# Locate the colcon workspace containing subsystems_ros2 / video_ros2.
# ---------------------------------------------------------------------------
find_workspace() {
  local candidate
  # 1. Explicit override.
  if [[ -n "$ROVER_WS" && -f "$ROVER_WS/install/setup.bash" ]]; then
    echo "$ROVER_WS"
    return 0
  fi
  # 2. The directory holding this script (if the script lives in a workspace).
  if [[ -f "$SELF/install/setup.bash" ]]; then
    echo "$SELF"
    return 0
  fi
  # 2b. A local ROS2 install generated from this Rover-Code checkout.
  if [[ -f "$SELF/.ros_install_ros2/setup.bash" ]]; then
    echo "$SELF"
    return 0
  fi
  # 3. Conventional default.
  if [[ -f "$HOME/rover_ws/install/setup.bash" ]]; then
    echo "$HOME/rover_ws"
    return 0
  fi
  # 4. Any ~/..._ws that has been built with colcon.
  for candidate in "$HOME"/*_ws; do
    [[ -f "$candidate/install/setup.bash" ]] || continue
    echo "$candidate"
    return 0
  done
  return 1
}

ROS_DIR="$(find_ros_distro)"
WORKSPACE="$(find_workspace)"

if [[ -z "$ROS_DIR" ]]; then
  echo "error: no ROS2 installation found under /opt/ros" >&2
  exit 1
fi

# A built workspace is only required to *run* the ROS2 stack. `pi build`
# creates one inside this checkout, so an empty WORKSPACE is not fatal here.
ROS_INSTALL=""
if [[ -n "$WORKSPACE" ]]; then
  if [[ -f "$WORKSPACE/.ros_install_ros2/setup.bash" ]]; then
    ROS_INSTALL="$WORKSPACE/.ros_install_ros2"
  else
    ROS_INSTALL="$WORKSPACE/install"
  fi
  # shellcheck disable=SC1090
  source "$ROS_INSTALL/setup.bash"
fi

# shellcheck disable=SC1090
source "$ROS_DIR/setup.bash"

LOG_DIR="${WORKSPACE:-$SELF}/logs"
mkdir -p "$LOG_DIR"

# The unchanged Dashboard is configured to reach the rover at these addresses. Add
# them as /32 aliases to the active interface for local simulation/testing, then
# remove only aliases that this launcher added when the stack stops.
DASHBOARD_ADDRESSES=("192.168.1.20/32" "192.168.1.30/32")
DASHBOARD_ALIAS_MARKER="$LOG_DIR/.dashboard_addresses_added"

ensure_dashboard_addresses() {
  local address iface
  iface="$(ip route get "${DASHBOARD_ADDRESSES[0]%/*}" | awk '/dev/ {for (i=1;i<=NF;i++) if ($i=="dev") {print $(i+1); exit}}')"
  if [[ -z "$iface" ]]; then
    echo "error: could not determine the network interface for Dashboard addresses" >&2
    return 1
  fi
  : > "$DASHBOARD_ALIAS_MARKER.tmp"
  for address in "${DASHBOARD_ADDRESSES[@]}"; do
    if ip -4 addr show dev "$iface" | grep -qE "inet ${address%/*}/"; then
      echo "Dashboard address ${address%/*} already assigned on $iface"
      continue
    fi
    sudo ip addr add "$address" dev "$iface"
    printf '%s %s\n' "$address" "$iface" >> "$DASHBOARD_ALIAS_MARKER.tmp"
    echo "Added Dashboard address $address on $iface"
  done
  if [[ -s "$DASHBOARD_ALIAS_MARKER.tmp" ]]; then
    mv "$DASHBOARD_ALIAS_MARKER.tmp" "$DASHBOARD_ALIAS_MARKER"
  else
    rm -f "$DASHBOARD_ALIAS_MARKER.tmp" "$DASHBOARD_ALIAS_MARKER"
  fi
}

remove_dashboard_addresses() {
  local address iface
  [[ -f "$DASHBOARD_ALIAS_MARKER" ]] || return 0
  while read -r address iface; do
    [[ -n "$address" && -n "$iface" ]] || continue
    sudo ip addr del "$address" dev "$iface" || true
    echo "Removed Dashboard address $address from $iface"
  done < "$DASHBOARD_ALIAS_MARKER"
  rm -f "$DASHBOARD_ALIAS_MARKER"
}

NODES="udp_bridge firmware_manager gps_node imu_node subsystems_node video_node autonomy_node"

# Nodes that make up the standalone Pi Zero 2 W video stack.
PI_NODES="video_node"

# The Dart versions of the same programs run as systemd services named <name>.service
# (executables at $HOME/<name>, generated by `dart run :rover` in Rover-Code), and can
# also be launched manually. Stop all of these before running the ROS2 versions so the
# two implementations never fight over the same UDP ports.
DART_SERVICES="subsystems video"
DART_PATTERN="$HOME/(subsystems|video)( |$)"
DART_RUN_PATTERN='dart .*(bin/)?(subsystems|video)\.dart'

# Match nodes by full command line: process names are truncated to 15 chars by the
# kernel, so `pkill -x firmware_manager` would never match. Pinning to the workspace
# install path (install/<pkg>/lib/<pkg>/<node>) also avoids killing unrelated
# processes that happen to share a node name. $ROS_INSTALL is escaped so that paths
# with special regex characters (or symlinks like /root) still match correctly.
NODE_PATTERN="$(printf '%s' "$ROS_INSTALL" | sed 's/[][\.*^$()+?{}|]/\\&/g')/[^/]+/lib/[^/]+/"

is_running() {
  pgrep -f "$NODE_PATTERN$1( |$)" > /dev/null
}

# Stop the ROS2 nodes. A no-op when nothing has been built yet: with an empty
# $ROS_INSTALL the generic NODE_PATTERN would match unrelated processes.
stop_ros_nodes() {
  if [[ -z "$ROS_INSTALL" ]]; then
    return 0
  fi
  pkill -f "$NODE_PATTERN" 2> /dev/null
  pkill -x ros2 2> /dev/null
}

# ---------------------------------------------------------------------------
# Pi Zero 2 W support: compile and run the video program standalone.
# `./run_rover.sh pi build` compiles with RealSense off and -j1/-j2 so the
# 512 MB board does not run out of memory; `./run_rover.sh pi start` streams
# the Pi cameras straight to the Dashboard on UDP :8002.
# ---------------------------------------------------------------------------

count_pi_cpus() {
  local cpus
  cpus="$(nproc)"
  if [[ "$cpus" -ge 4 ]]; then
    echo 2   # Zero 2 W: 4 cores but only 512 MB RAM; the linker OOMs with -j4
  else
    echo 1
  fi
}

pi_build() {
  local jobs
  jobs="$(count_pi_cpus)"
  echo "Building video_ros2 for the Pi Zero 2 W (make -j$jobs, RealSense disabled)..."
  # Pi builds always live inside this checkout (.ros_build_ros2/.ros_install_ros2),
  # so `pi build` works on a fresh clone without an existing workspace.
  mkdir -p "$SELF/.ros_build_ros2" "$SELF/.ros_install_ros2"
  colcon build \
    --base-paths "$SELF/subsystems_ros2" "$SELF/video_ros2" \
    --build-base "$SELF/.ros_build_ros2" \
    --install-base "$SELF/.ros_install_ros2" \
    --packages-select subsystems_ros2 video_ros2 \
    --cmake-args -DBUILD_TESTING=OFF -DVIDEO_ROS2_ENABLE_REALSENSE=OFF \
    --parallel-workers 1 --executor sequential \
    --event-handlers console_direct+ \
    --make-args "-j$jobs"
  echo "Done. Start streaming with: $0 pi start"
}

start_pi_programs() {
  if [[ -z "$ROS_INSTALL" || ! -f "$ROS_INSTALL/video_ros2/share/video_ros2/launch/video_pi.launch.py" ]]; then
    echo "video_ros2 is not built yet. Run '$0 pi build' first." >&2
    exit 1
  fi
  # Stop leftovers first so UDP port 8002 is free.
  stop_pi_programs

  echo "Starting video (Pi Zero 2 W standalone, dashboard protocol on UDP :8002)..."
  setsid nohup ros2 launch video_ros2 video_pi.launch.py \
    > "$LOG_DIR/video.log" 2>&1 < /dev/null &
  disown

  sleep 3
  status_pi_programs
  echo "Log: $LOG_DIR/video.log"
}

stop_pi_programs() {
  stop_ros_nodes
  sleep 1
}

status_pi_programs() {
  local any=0
  for node in $PI_NODES; do
    if is_running "$node"; then
      echo "  [running] $node"
      any=1
    fi
  done
  if [[ $any -eq 0 ]]; then
    echo "  video_node is not running"
  fi
}

start_programs() {
  if [[ -z "$ROS_INSTALL" ]]; then
    echo "error: could not find a colcon workspace with install/setup.bash." >&2
    echo "       Build one (colcon build), set ROVER_WS=/path/to/workspace, or use 'pi build'." >&2
    exit 1
  fi
  # Stop leftovers first so ports 8001/8002 are free.
  stop_programs
  ensure_dashboard_addresses || exit 1

  echo "Starting subsystems (ports 8001 + 8002)..."
  setsid nohup ros2 launch subsystems_ros2 subsystems.launch.py \
    > "$LOG_DIR/subsystems.log" 2>&1 < /dev/null &
  disown

  # On Raspberry Pi hardware, use the launch file that reads the camera
  # connected to the Pi camera connector (CSI) through GStreamer/libcamera.
  # Everywhere else (including dev VMs), run the all-virtual test cameras.
  # udp_server_enabled is disabled here: udp_bridge fronts the video program
  # on UDP :8002 in the full rover stack. The standalone Pi mode ('pi start')
  # is what enables it.
  VIDEO_LAUNCH="video.launch.py"
  VIDEO_DESC="all virtual test cameras"
  VIDEO_ARGS=()
  if grep -q "Raspberry Pi" /sys/firmware/devicetree/base/model 2>/dev/null; then
    VIDEO_LAUNCH="video_pi.launch.py"
    VIDEO_DESC="Pi CSI camera (GStreamer/libcamera)"
    VIDEO_ARGS=("udp_server_enabled:=false")
  fi

  echo "Starting video ($VIDEO_DESC)..."
  setsid nohup ros2 launch video_ros2 "$VIDEO_LAUNCH" "${VIDEO_ARGS[@]}" \
    > "$LOG_DIR/video.log" 2>&1 < /dev/null &
  disown

  echo "Starting autonomy (Dashboard port 8003, curved path follower)..."
  setsid nohup ros2 launch autonomy_ros2 autonomy.launch.py \
    > "$LOG_DIR/autonomy.log" 2>&1 < /dev/null &
  disown

  sleep 5
  status_programs
  echo "Logs: $LOG_DIR/subsystems.log, $LOG_DIR/video.log, $LOG_DIR/autonomy.log"
}

stop_programs() {
  stop_ros_nodes

  # Stop the Dart versions: the systemd services first, then any manually
  # launched executables or `dart run` instances.
  if command -v systemctl > /dev/null; then
    for service in $DART_SERVICES; do
      systemctl is-active --quiet "$service" 2> /dev/null || continue
      echo "Stopping dart service: $service.service"
      sudo systemctl stop "$service.service" || echo "  warning: could not stop $service.service (sudo denied?)"
    done
  fi
  pkill -f "$DART_PATTERN" 2> /dev/null
  pkill -f "$DART_RUN_PATTERN" 2> /dev/null
  remove_dashboard_addresses
  sleep 2
}

status_programs() {
  local any=0
  for node in $NODES; do
    if is_running "$node"; then
      echo "  [running] $node"
      any=1
    fi
  done
  for service in $DART_SERVICES; do
    if systemctl is-active --quiet "$service" 2> /dev/null; then
      echo "  [running] dart $service.service"
      any=1
    fi
  done
  if [[ $any -eq 0 ]]; then
    echo "  no rover programs are running"
  fi
}

case "${1:-start}" in
  start)   start_programs ;;
  stop)    stop_programs;  status_programs ;;
  status)  status_programs ;;
  restart) stop_programs;  start_programs ;;
  pi)
    shift
    case "${1:-start}" in
      build)   pi_build ;;
      start)   start_pi_programs ;;
      stop)    stop_pi_programs; status_pi_programs ;;
      status)  status_pi_programs ;;
      restart) stop_pi_programs; start_pi_programs ;;
      *)
        echo "Usage: $0 pi [build|start|stop|status|restart]"
        exit 1
        ;;
    esac
    ;;
  *)
    echo "Usage: $0 [start|stop|status|restart]"
    echo "       $0 pi [build|start|stop|status|restart]"
    exit 1
    ;;
esac
