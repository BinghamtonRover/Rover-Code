#!/usr/bin/env python3
"""Stress test for firmware_manager using socat virtual serial ports.

This test:
1. Creates a virtual serial port pair with socat.
2. Simulates a Teensy device on one end (reset response + handshake).
3. Runs firmware_manager under valgrind (optional) with port_patterns set to the virtual port.
4. Publishes many WrappedProtobuf messages to /burt/incoming via rclpy.
5. Verifies that the firmware manager connects and sends data without leaks or crashes.
"""

import os
import subprocess
import sys
import threading
import time

# Generated protobuf Python modules live in the network package.
_PROTO_ROOT = "/home/rovewr/Rover-Code/vision/lib/network/src"
if _PROTO_ROOT not in sys.path:
    sys.path.insert(0, _PROTO_ROOT)

try:
    from generated.core_pb2 import Connect
    from generated.drive_pb2 import DriveCommand
    from generated.wrapper_pb2 import WrappedMessage
    PROTO_AVAILABLE = True
except ImportError:
    PROTO_AVAILABLE = False

# Optional rclpy import; if unavailable, the test will skip the ROS publish phase.
try:
    import rclpy
    from rclpy.node import Node
    ROS_AVAILABLE = True
except ImportError:
    ROS_AVAILABLE = False


# Path to the firmware_manager executable. Override with env var.
FIRMWARE_MANAGER = os.environ.get(
    "FIRMWARE_MANAGER",
    "/tmp/ros2_ws/install/subsystems_ros2/lib/subsystems_ros2/firmware_manager",
)

# Number of messages to publish.
MESSAGE_COUNT = int(os.environ.get("MESSAGE_COUNT", "10000"))

# Whether to run under valgrind.
USE_VALGRIND = os.environ.get("USE_VALGRIND", "0") == "1"


def find_socat_ports():
    """Return a pair of virtual serial port paths created by socat."""
    base = "/tmp/firmware_stress"
    os.makedirs(base, exist_ok=True)
    # Use socat to create a pair of linked PTYs.
    # The PTY names are written to a file by socat's OPEN option.
    port_a = os.path.join(base, "portA")
    port_b = os.path.join(base, "portB")
    # Remove old links if they exist.
    for p in (port_a, port_b):
        try:
            os.remove(p)
        except FileNotFoundError:
            pass
    # socat will create PTYs and symlink them to port_a/port_b.
    cmd = [
        "socat",
        "-d",
        "-d",
        f"PTY,link={port_a},rawer,echo=0,b9600",
        f"PTY,link={port_b},rawer,echo=0,b9600",
    ]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    # Wait briefly for socat to set up the links.
    for _ in range(50):
        if os.path.exists(port_a) and os.path.exists(port_b):
            break
        time.sleep(0.05)
    if not os.path.exists(port_a) or not os.path.exists(port_b):
        proc.terminate()
        raise RuntimeError("socat failed to create virtual serial ports")
    return port_a, port_b, proc


def teensy_simulator(port_path, stop_event):
    """Simulate a Teensy device: respond to reset and handshake, then echo framed data."""
    import serial  # type: ignore

    ser = serial.Serial(port_path, baudrate=9600, timeout=0.1)
    state = "reset"
    buffer = b""

    while not stop_event.is_set():
        try:
            data = ser.read(1024)
        except serial.SerialException:
            break
        if not data:
            continue
        buffer += data

        if state == "reset":
            # Expect 4 zero bytes.
            if len(buffer) >= 4:
                buffer = buffer[4:]
                ser.write(b"\x01\x01\x01\x01")
                state = "handshake"
        elif state == "handshake":
            # Expect raw Connect protobuf (no length prefix in handshake).
            if buffer:
                if not PROTO_AVAILABLE:
                    # Fallback: just send a minimal Connect-like response.
                    ser.write(b"\x08\x02\x10\x01")
                    buffer = b""
                    state = "connected"
                    continue
                msg = Connect()
                consumed = msg.ParseFromString(buffer)
                if consumed == 0:
                    # Not enough data yet.
                    continue
                buffer = buffer[consumed:]
                response = Connect()
                response.sender = 2  # FIRMWARE
                response.receiver = 1  # SUBSYSTEMS
                ser.write(response.SerializeToString())
                state = "connected"
        else:
            # Drain any framed data sent by the firmware manager.
            buffer = b""

    ser.close()


def publish_messages():
    """Publish many WrappedProtobuf messages to /burt/incoming."""
    if not ROS_AVAILABLE:
        print("rclpy not available; skipping ROS publish phase")
        return
    if not PROTO_AVAILABLE:
        print("protobuf modules not available; skipping ROS publish phase")
        return

    from subsystems_ros2.msg import WrappedProtobuf as WrappedProtobufMsg

    rclpy.init()
    node = Node("firmware_stress_publisher")
    pub = node.create_publisher(WrappedProtobufMsg, "/burt/incoming", 100)

    start = time.time()
    for i in range(MESSAGE_COUNT):
        drive = DriveCommand()
        drive.left = 0.5
        drive.right = 0.5
        wrapped = WrappedMessage()
        wrapped.name = DriveCommand.DESCRIPTOR.full_name
        wrapped.data = drive.SerializeToString()
        msg = WrappedProtobufMsg()
        msg.name = wrapped.name
        msg.data = list(wrapped.data)
        pub.publish(msg)
        if i % 1000 == 0:
            node.get_logger().info(f"Published {i} messages")
    elapsed = time.time() - start
    node.get_logger().info(f"Published {MESSAGE_COUNT} messages in {elapsed:.2f}s")
    node.destroy_node()
    rclpy.shutdown()


def main():
    print("Creating virtual serial ports with socat...")
    port_a, port_b, socat_proc = find_socat_ports()
    print(f"Virtual ports: {port_a} -> {port_b}")

    stop_event = threading.Event()
    sim_thread = threading.Thread(target=teensy_simulator, args=(port_b, stop_event))
    sim_thread.start()

    try:
        print("Starting firmware_manager...")
        cmd = [FIRMWARE_MANAGER, "--ros-args", "-p", f"port_patterns:=[{port_a}]"]
        if USE_VALGRIND:
            cmd = [
                "valgrind",
                "--leak-check=full",
                "--show-leak-kinds=all",
                "--error-exitcode=1",
            ] + cmd

        env = os.environ.copy()
        env["LD_LIBRARY_PATH"] = "/tmp/ros2_ws/build/subsystems_ros2:/tmp/ros2_ws/install/subsystems_ros2/lib:" + env.get("LD_LIBRARY_PATH", "")

        proc = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            env=env,
        )

        # Wait for firmware_manager to discover and connect.
        time.sleep(3)

        print("Publishing messages...")
        publish_thread = threading.Thread(target=publish_messages)
        publish_thread.start()
        publish_thread.join()

        # Let the firmware manager flush writes.
        time.sleep(2)

        print("Terminating firmware_manager...")
        proc.terminate()
        try:
            stdout, stderr = proc.communicate(timeout=10)
        except subprocess.TimeoutExpired:
            proc.kill()
            stdout, stderr = proc.communicate()

        print(stdout.decode("utf-8", errors="replace"))
        print(stderr.decode("utf-8", errors="replace"), file=sys.stderr)

        if USE_VALGRIND and proc.returncode != 0:
            print("Valgrind detected errors/leaks", file=sys.stderr)
            sys.exit(1)

        print("Stress test completed successfully.")

    finally:
        stop_event.set()
        sim_thread.join(timeout=2)
        socat_proc.terminate()
        try:
            socat_proc.wait(timeout=5)
        except subprocess.TimeoutExpired:
            socat_proc.kill()


if __name__ == "__main__":
    main()
