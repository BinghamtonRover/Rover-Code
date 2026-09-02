from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    # CameraName enum values from burt_network/Protobuf/video.proto:
    # CAMERA_NAME_UNDEFINED = 0
    # ROVER_FRONT = 1
    # ROVER_REAR = 2
    # AUTONOMY_DEPTH = 3
    # SUBSYSTEM1 = 4
    # SUBSYSTEM2 = 5
    # SUBSYSTEM3 = 6
    # BOTTOM_LEFT = 7
    # BOTTOM_RIGHT = 8
    return LaunchDescription([
        Node(
            package='video_ros2',
            executable='video_node',
            name='video_node',
            output='screen',
            parameters=[{
                # Every camera streams the synthetic test pattern. To use real
                # hardware, set 'virtual_mode': False and put V4L2 device paths
                # in camera_devices (or the special value 'virtual' per entry).
                'camera_names': [
                    'rover_front', 'rover_rear', 'autonomy_depth',
                    'subsystem1', 'subsystem2', 'subsystem3',
                    'bottom_left', 'bottom_right',
                ],
                'camera_devices': ['virtual'] * 8,
                # camera_types must match CameraName enum values above.
                'camera_types': [1, 2, 3, 4, 5, 6, 7, 8],
                # Generate synthetic test frames instead of reading real cameras.
                'virtual_mode': True,
                'virtual_width': 640,
                'virtual_height': 480,
                'virtual_fps': 30,
                'virtual_quality': 75,
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
