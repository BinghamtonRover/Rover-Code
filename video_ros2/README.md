# video_ros2

ROS2 C++ replacement for the legacy Dart `video` program. It manages USB V4L2
cameras and Intel RealSense depth cameras, publishes compressed JPEG frames,
detects ArUco markers, and forwards commands/frames to auxiliary programs over
UDP.

## Cameras

Cameras are configured through ROS parameters:

| Parameter | Type | Description |
|-----------|------|-------------|
| `camera_names` | `string[]` | Human-readable names (e.g. `rover_rear`). |
| `camera_devices` | `string[]` | V4L2 device paths (e.g. `/dev/video0`). |
| `camera_types` | `int[]` | `CameraName` enum values from `video.proto`. |
| `screenshot_dir` | `string` | Directory for screenshots. Default: `/home/rover/shared/screenshots`. |
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
