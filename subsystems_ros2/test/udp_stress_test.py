#!/usr/bin/env python3
"""Stress test for the UDP bridge."""
import socket
import sys
import time
import os

# Use the generated Python protobuf bindings from the vision package.
sys.path.insert(0, "/home/rovewr/Rover-Code/vision/lib/network/src/generated")
from wrapper_pb2 import WrappedMessage
from core_pb2 import Connect, SUBSYSTEMS, DASHBOARD


def make_wrapped(name: str, data: bytes) -> bytes:
    wrapper = WrappedMessage()
    wrapper.name = name
    wrapper.data = data
    return wrapper.SerializeToString()


def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.settimeout(1.0)

    # Send a Connect heartbeat so the bridge learns our address.
    connect = Connect()
    connect.sender = SUBSYSTEMS
    connect.receiver = DASHBOARD
    sock.sendto(make_wrapped(Connect.DESCRIPTOR.full_name, connect.SerializeToString()), ("127.0.0.1", 8001))

    name = Connect.DESCRIPTOR.full_name
    data = connect.SerializeToString()
    message = make_wrapped(name, data)

    count = int(sys.argv[1]) if len(sys.argv) > 1 else 10000
    start = time.time()
    for _ in range(count):
        sock.sendto(message, ("127.0.0.1", 8001))
    elapsed = time.time() - start
    print(f"Sent {count} messages in {elapsed:.2f} s ({count / elapsed:.0f} msg/s)")

    # Receive any responses for a short while.
    try:
        for _ in range(10):
            data, addr = sock.recvfrom(65535)
            print(f"Received {len(data)} bytes from {addr}")
    except socket.timeout:
        pass


if __name__ == "__main__":
    main()
