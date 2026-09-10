from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    """Launch configuration for the Raspberry Pi Zero 2 W.

    This launch file runs the video program as a *standalone* streaming node:
    it serves the BURT dashboard protocol itself on UDP port 8002
    ('udp_server_enabled': True), so the Pi streams its cameras straight to
    the Dashboard without any central video streamer. Several Pi Zero 2 W
    boards can run this same launch file at once, each streaming a different
    set of cameras to the Dashboard; the Dashboard connects to each board
    independently (no changes needed on the Dashboard side).

    The Pi camera connector (CSI) camera is exposed through the libcamera
    stack on Raspberry Pi OS Bullseye/Bullseye+; it has no usable /dev/video
    capture node, so the 'csi' device path selects the GStreamer
    libcamerasrc backend. USB cameras can be listed as plain /dev/videoN
    paths (OpenCV V4L2) or 'v4l2:/dev/videoN' (GStreamer).

    To stream multiple cameras from one Pi, add entries to the three camera
    lists. To run several Pis, keep one camera per board and give each board
    a distinct CameraName (dashboard slots) and its own IP address.

    CameraName enum values from burt_network/Protobuf/video.proto:
    CAMERA_NAME_UNDEFINED = 0
    ROVER_FRONT = 1
    ROVER_REAR = 2
    AUTONOMY_DEPTH = 3
    SUBSYSTEM1 = 4
    SUBSYSTEM2 = 5
    SUBSYSTEM3 = 6
    BOTTOM_LEFT = 7
    BOTTOM_RIGHT = 8
    """
    udp_server_enabled = LaunchConfiguration('udp_server_enabled')

    return LaunchDescription([
        # Whether the video node serves the BURT dashboard protocol itself
        # (standalone Pi streaming). Enabled by default; './run_rover.sh start'
        # overrides it to false because udp_bridge fronts the video program on
        # UDP :8002 in the full rover stack.
        DeclareLaunchArgument(
            'udp_server_enabled',
            default_value='true',
            description='Serve the dashboard protocol directly on UDP :8002',
        ),
        Node(
            package='video_ros2',
            executable='video_node',
            name='video_node',
            output='screen',
            parameters=[{
                # Serve the dashboard protocol directly on UDP :8002. Disable
                # this on the main rover, where udp_bridge already fronts the
                # video program on that port.
                'udp_server_enabled': udp_server_enabled,
                'udp_server_port': 8002,
                'udp_server_max_clients': 5,
                # One camera on the Pi CSI port. Add more entries (with matching
                # device/type lists) for USB cameras.
                'camera_names': ['rover_front'],
                # 'csi' -> GStreamer libcamerasrc (Pi camera connector).
                # Other supported values: '/dev/videoN' (OpenCV V4L2),
                # 'v4l2:/dev/videoN' (GStreamer V4L2), 'virtual' (synthetic).
                'camera_devices': ['csi'],
                'camera_types': [1],
                # libcamera fails if the camera does not support the requested
                # mode; 640x480@30 is safe on the Zero 2 W. JPEG encoding runs
                # on the CPU, so keep the resolution modest.
                'default_width': 640,
                'default_height': 480,
                'default_fps': 30,
                # ArUco detector configuration.
                'aruco_dictionary': 'DICT_4X4_50',
                'aruco_adaptive_thresh_win_size_min': 3,
                'aruco_adaptive_thresh_win_size_max': 23,
                'aruco_adaptive_thresh_win_size_step': 10,
                'aruco_adaptive_thresh_constant': 7.0,
                'aruco_min_marker_perimeter_rate': 0.03,
                'aruco_max_marker_perimeter_rate': 4.0,
                'aruco_polygonal_approx_accuracy_rate': 0.05,
                'aruco_min_corner_distance_rate': 0.05,
                'aruco_min_distance_to_borders': 3,
                'aruco_corner_refinement_method': 0,
            }],
        ),
    ])
