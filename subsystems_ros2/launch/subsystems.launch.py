from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='subsystems_ros2',
            executable='udp_bridge',
            name='udp_bridge',
            output='screen',
            parameters=[{
                'port': 8001,
                'max_clients': 5,
            }],
        ),
        Node(
            package='subsystems_ros2',
            executable='firmware_manager',
            name='firmware_manager',
            output='screen',
        ),
        Node(
            package='subsystems_ros2',
            executable='gps_node',
            name='gps_node',
            output='screen',
            parameters=[{
                'port': '/dev/rover_gps',
                'use_gps': True,
            }],
        ),
        Node(
            package='subsystems_ros2',
            executable='imu_node',
            name='imu_node',
            output='screen',
            parameters=[{
                'port': '/dev/rover_imu',
                'use_imu': True,
            }],
        ),
        Node(
            package='subsystems_ros2',
            executable='subsystems_node',
            name='subsystems_node',
            output='screen',
            parameters=[{
                'status_period': 0.25,
            }],
        ),
    ])
