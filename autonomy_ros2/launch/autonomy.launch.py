from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='autonomy_ros2',
            executable='autonomy_node',
            name='autonomy_node',
            output='screen',
            parameters=[{
                'port': 8003,
                'simulation_mode': True,
                'allow_hardware_drive': False,
                'simulation_latitude': 42.0987,
                'simulation_longitude': -75.9657,
            }],
        ),
    ])
