# video_ros2

ROS2 C++ replacement for the legacy Dart `video` program. It manages USB V4L2
cameras, Raspberry Pi CSI cameras (through GStreamer/libcamera), and Intel
RealSense depth cameras, publishes compressed JPEG frames, detects ArUco
markers, and forwards commands/frames to auxiliary programs over UDP.

It builds and runs on x86_64 machines and on the Raspberry Pi Zero 2 W
(aarch64, Raspberry Pi OS Bullseye/Bullseye+). On the Pi Zero 2 W it can run
**standalone**: the node serves the BURT dashboard protocol itself on UDP port
8002, so each Pi streams its cameras straight to the Dashboard with no central
video streamer (see [Standalone streaming on the Pi Zero 2 W](#standalone-streaming-on-the-pi-zero-2-w)).

## Raspberry Pi Zero 2 W setup

The Pi camera connector (CSI port) does **not** provide a normal `/dev/video`
capture device on Bullseye/Bullseye+; the camera is only reachable through the
libcamera stack. This package ships a GStreamer camera backend
(`GStreamerCamera`, `libcamerasrc -> videoconvert -> appsink`) for exactly that.

### 1. OS and ROS

Use **Raspberry Pi OS (64-bit)** Lite Bullseye or Bullseye+ (aarch64). ROS 2
Humble supports Bullseye; see [docs.ros.org](https://docs.ros.org/en/humble/Installation/Alternatives/Raspbian-Install-Ros2.html).
Give the Zero 2 W some headroom (it has 512 MB RAM):

```bash
# /boot/config.txt or /boot/firmware/config.txt
gpu_mem=64
```

Build with `make -j2` (or `make -j1`); with 4 cores and 512 MB RAM the linker
will OOM otherwise.

### 2. Enable the CSI camera

```bash
sudo raspi-config   # Interface Options -> Camera -> Enable, then reboot
dmesg | grep -iE "imx|ov5647|libcamera"   # should list your camera sensor
```

In `/boot/config.txt` (or `/boot/firmware/config.txt`), the camera autodetect
blob should be present:

```
camera_auto_detect=1
```

### 3. Install dependencies

```bash
sudo apt update
sudo apt install -y \
  build-essential cmake python3-colcon-common-extensions \
  libopencv-dev libprotobuf-dev protobuf-compiler \
  libjpeg62-turbo-dev \
  libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
  gstreamer1.0-libcamera gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
  gstreamer1.0-tools
```

`libjpeg62-turbo-dev` is optional (SIMD-accelerated JPEG encoding; OpenCV's
encoder is the fallback when it is absent). On Ubuntu it is named
`libjpeg-turbo8-dev` instead, which is why it is not a rosdep dependency of
this package.

`gstreamer1.0-libcamera` provides the `libcamerasrc` element. RealSense is
optional and is compiled out when `librealsense2-dev` is absent (the Zero 2 W
cannot run the librealsense pipeline usefully anyway).

Verify the camera through GStreamer first:

```bash
libcamera-hello --list-cameras          # rpicam/libcamera tools
gst-launch-1.0 libcamerasrc ! fakesink   # should run without errors
```

### 4. Protobuf note (Bullseye)

The generated protobuf sources checked into `subsystems_ros2` were made with
protoc 3.12 (Ubuntu 20.04/22.04). Bullseye ships protobuf 3.21, whose headers
reject older generated files at compile time. The build detects this and
regenerates the protobufs automatically from the `burt_network/Protobuf`
submodule. Make sure the submodule is present:

```bash
git submodule update --init
```

### 5. Build

On the Pi, use the dedicated flag in `run_rover.sh`, which compiles with
RealSense disabled and build parallelism safe for the 512 MB board:

```bash
cd ~/Rover-Code
./run_rover.sh pi build
```

That is equivalent to:

```bash
cd ~/Rover-Code
source /opt/ros/humble/setup.bash
colcon build \
  --base-paths subsystems_ros2 video_ros2 \
  --build-base .ros_build_ros2 --install-base .ros_install_ros2 \
  --packages-select subsystems_ros2 video_ros2 \
  --cmake-args -DBUILD_TESTING=OFF -DVIDEO_ROS2_ENABLE_REALSENSE=OFF \
  --parallel-workers 1 --executor sequential --event-handlers console_direct+ \
  --make-args "-j2"
```

Or use a classic symlinked workspace:

```bash
cd ~/Rover-Code
mkdir -p ws/src
ln -sfn "$PWD/subsystems_ros2" ws/src/subsystems_ros2
ln -sfn "$PWD/video_ros2" ws/src/video_ros2
cd ws
source /opt/ros/humble/setup.bash
colcon build --packages-select subsystems_ros2 video_ros2 \
  --cmake-args -DBUILD_TESTING=OFF -DVIDEO_ROS2_ENABLE_REALSENSE=OFF \
  --parallel-workers 1 \
  --event-handlers console_direct+ --executor sequential --make-args "-j2"
```

### 6. Run

```bash
source /opt/ros/humble/setup.bash
source install/setup.bash
ros2 launch video_ros2 video_pi.launch.py
```

`video_pi.launch.py` starts the camera connected to the CSI port as
`rover_front` at 640x480@30 (a safe mode for the Zero 2 W; JPEG encoding is
cpu-bound). Or use the general launcher, which auto-selects the Pi launch file
on Pi hardware:

```bash
./run_rover.sh
```

Device-path cheat sheet (`camera_devices`):

| Value | Backend | Use for |
|---|---|---|
| `csi` or `libcamera` | GStreamer `libcamerasrc` | Pi camera connector (CSI) |
| `/dev/video0` | OpenCV V4L2 | USB webcams |
| `v4l2:/dev/video0` | GStreamer `v4l2src` | USB cameras via GStreamer |
| `virtual` | Synthetic frames | Testing without hardware |
| `test` | GStreamer `videotestsrc` | GStreamer diagnostics |

### Pi troubleshooting

* `pipeline did not reach PLAYING` from `libcamerasrc`: the mode
  (`default_width`/`default_height`/`default_fps`) is unsupported by the
  sensor, or another process (libcamera-hello, rpicam-*) holds the camera.
* Frames but no video on the dashboard: check `ros2 topic hz /burt/video_data`
  and that the Dashboard can reach the rover's IP.
* Low fps: lower `default_width`/`default_height`, lower `quality`, or disable
  ArUco detection; all three are CPU-bound on the Zero 2 W.
* `Frame from ... too large ... at minimum quality`: the frames cannot fit in
  one UDP datagram (see below). Lower `default_width`/`default_height`.
* `user` not in `video` group: `sudo usermod -aG video $USER` and re-login.

### Network bandwidth (UDP frame cap)

Like the Dart video program, every `VideoData` message must fit in one UDP
datagram (60,000 bytes of frame data). A frame that does not fit is dropped --
sending it would only waste bandwidth, since the Dashboard can never receive
it -- and the camera's JPEG quality is lowered by 1 for the next frame. When
the quality reaches 25 the camera reports `FRAME_TOO_LARGE` to the Dashboard
instead. The Dashboard can also send a camera `CAMERA_DISABLED` (freeing CPU
and bandwidth on the Pi) and re-enable it later.

When the node runs standalone (`udp_server_enabled:=true`), frames are only
serialized and broadcast while at least one dashboard is connected, so an idle
Pi streams nothing.

## Cameras

Cameras are configured through ROS parameters:

| Parameter | Type | Description |
|-----------|------|-------------|
| `camera_names` | `string[]` | Human-readable names (e.g. `rover_rear`). |
| `camera_devices` | `string[]` | Device paths: `/dev/video0` (V4L2), `csi`/`libcamera` (Pi CSI via GStreamer), `v4l2:/dev/videoN` (GStreamer), `virtual` (synthetic), `test` (GStreamer test source). |
| `camera_types` | `int[]` | `CameraName` enum values from `video.proto`. |
| `default_width` | `int` | Default resolution width for cameras that do not set one (0 = backend default). |
| `default_height` | `int` | Default resolution height (0 = backend default). |
| `default_fps` | `int` | Default frame rate (0 = backend default). |
| `screenshot_dir` | `string` | Directory for screenshots. Default: `/home/rover/shared/screenshots`. |
| `udp_server_enabled` | `bool` | Serve the BURT dashboard protocol (UDP) directly from this node instead of relying on a central video streamer. Used by the standalone Pi Zero 2 W setup. Default: `false`. |
| `udp_server_port` | `int` | UDP port the standalone dashboard server listens on. Default: `8002`. |
| `udp_server_max_clients` | `int` | Maximum number of simultaneous dashboard connections for the standalone server. Default: `5`. |
| `aux_address` | `string` | IP/hostname of the auxiliary command forwarder. Empty disables forwarding. |
| `aux_port` | `int` | UDP port for the auxiliary command forwarder. Default: `8011`. |
| `echo_commands` | `bool` | Echo received `VideoCommand` messages back to the dashboard. Default: `true`. |
| `vision_address` | `string` | IP/hostname of the vision/object-detection program. Empty disables forwarding. |
| `vision_port` | `int` | UDP port for the vision program. Default: `8006`. |
| `vision_camera_names` | `string[]` | Camera names whose frames are forwarded to the vision program. |
| `aruco_dictionary` | `string` | OpenCV predefined dictionary name. Default: `DICT_4X4_50`. |
| `aruco_adaptive_thresh_win_size_min` | `int` | ArUco adaptive threshold window size minimum. Default: `3`. |
| `aruco_adaptive_thresh_win_size_max` | `int` | ArUco adaptive threshold window size maximum. Default: `23`. |
| `aruco_adaptive_thresh_win_size_step` | `int` | ArUco adaptive threshold window size step. Default: `10`. |
| `aruco_adaptive_thresh_constant` | `double` | ArUco adaptive threshold constant. Default: `7.0`. |
| `aruco_min_marker_perimeter_rate` | `double` | ArUco minimum marker perimeter rate. Default: `0.03`. |
| `aruco_max_marker_perimeter_rate` | `double` | ArUco maximum marker perimeter rate. Default: `4.0`. |
| `aruco_polygonal_approx_accuracy_rate` | `double` | ArUco polygonal approximation accuracy rate. Default: `0.05`. |
| `aruco_min_corner_distance_rate` | `double` | ArUco minimum corner distance rate. Default: `0.05`. |
| `aruco_min_distance_to_borders` | `int` | ArUco minimum distance to borders. Default: `3`. |
| `aruco_corner_refinement_method` | `int` | ArUco corner refinement method. Default: `0`. |

`CameraName` enum values (from `burt_network/Protobuf/video.proto`):

```
CAMERA_NAME_UNDEFINED = 0
ROVER_FRONT           = 1
ROVER_REAR            = 2
AUTONOMY_DEPTH        = 3
SUBSYSTEM1            = 4
SUBSYSTEM2            = 5
SUBSYSTEM3            = 6
BOTTOM_LEFT           = 7
BOTTOM_RIGHT          = 8
```

## Standalone streaming on the Pi Zero 2 W

Several Pi Zero 2 W boards can each stream their own cameras straight to the
dashboard with no central video streamer. Each board runs this node with
`udp_server_enabled:=true` and serves the dashboard protocol itself, so the
dashboard needs no changes — it simply talks to each board's UDP port
individually.

- `run_rover.sh pi build` compiles the workspace on the Pi (RealSense disabled,
  build parallelism tuned for the 512 MB board).
- `run_rover.sh pi start` starts the standalone video stack using
  `video_pi.launch.py` (camera `rover_front` on the CSI port plus the UDP
  dashboard server on port 8002).
- Each additional Pi runs the same commands; give each board a different
  `camera_types`/`camera_names` set (e.g. one board is `ROVER_FRONT`, another
  `ROVER_REAR`, a third `BOTTOM_LEFT`/`BOTTOM_RIGHT`) so the dashboard can tell
  the streams apart.

The `udp_server_*` parameters (see table above) control the standalone server;
when `udp_server_enabled` is `false`, the node behaves exactly as before and
frames reach the dashboard through the rover's `udp_bridge`.

## Topics

| Topic | Type | Direction | Description |
|-------|------|-----------|-------------|
| `/burt/video_data` | `subsystems_ros2/msg/WrappedProtobuf` | Publish | Compressed `VideoData` protobuf messages. |
| `/burt/video_command` | `subsystems_ros2/msg/WrappedProtobuf` | Subscribe | Incoming `VideoCommand` protobuf messages. |
| `/burt/video_command_echo` | `subsystems_ros2/msg/WrappedProtobuf` | Publish | Echo of received commands (when enabled). |

## Building

```bash
cd /tmp/ros2_ws
colcon build --packages-select subsystems_ros2 video_ros2
```

Optional dependencies are detected automatically:

* `librealsense2-dev` enables RealSense support.
* `libturbojpeg` enables hardware/SIMD-accelerated JPEG encoding.
* GStreamer (`libgstreamer-1.0-dev`, `libgstreamer-plugins-base1.0-dev`) enables
  the CSI/libcamera camera backend. See [Raspberry Pi Zero 2 W setup](#raspberry-pi-zero-2-w-setup).
* OpenCV `aruco` module enables ArUco marker detection.

## Running

```bash
ros2 run video_ros2 video_node
```

Or with a launch file:

```bash
ros2 launch video_ros2 video.launch.py
```

## Testing

```bash
cd /tmp/ros2_ws
colcon test --packages-select video_ros2
```

The package includes a performance test (`test/test_performance.cpp`) that
measures JPEG encoding throughput and ArUco detection throughput at several
resolutions and quality settings.
