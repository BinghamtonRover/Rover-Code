#!/usr/bin/env python3
import arguably
import asyncio
import os


@arguably.command
def analyze(*, images_dir: str = "test_images", verbose: bool = False):
    """Analyze test images for mallet detection

    Args:
        images_dir: directory containing test images
        verbose
    """
    import cv2
    from lib.analyzer import ImageAnalyzer

    if verbose:
        print("Initializing...")
    analyzer = ImageAnalyzer()
    passed = failed = 0

    for file in os.listdir(images_dir):
        if "." not in file:
            continue
        filename, _ = file.split(".")
        if not filename:
            continue
        parts = filename.split("_")
        if len(parts) < 2:
            continue
        background, has_mallet = parts[0], parts[1]
        has_mallet = has_mallet == "yes"
        frame = cv2.imread(f"{images_dir}/{file}")
        if frame is None:
            continue
        result = analyzer.has_mallet(frame)
        if result == has_mallet:
            passed += 1
            if verbose:
                print(f"{background} image passed -- {result}")
        else:
            failed += 1
            print(
                f"{background} image failed: Analyzer detected {result} instead of {has_mallet}"
            )

    print(f"Results: {passed} passed, {failed} failed")


@arguably.command
def server(
    *,
    port: int = 8006,
    video_host: str = "127.0.0.1",
    video_port: int = 8002,
    jpg_quality: int = 60,
    max_packet_size: int = 60000,
):
    """Start the analyzer server

    Args:
        port: port to listen on for incoming frames
        video_host: host to send annotated frames to
        video_port: port to send annotated frames to
        jpg_quality: JPEG compression quality (1-100)
        max_packet_size: maximum UDP packet size in bytes
    """

    async def server_main():
        from lib.analyzer import ImageAnalyzer
        from lib.analyzer_server import AnalyzerServer
        from lib.network import UdpSocket
        from lib.network.generated import Device

        socket = await UdpSocket.create(port=port, device=Device.VISION)
        analyzer = ImageAnalyzer()
        video_dest = (video_host, video_port)

        server = AnalyzerServer(
            socket, analyzer, jpg_quality, max_packet_size, video_dest
        )
        print(
            f"starting analyzer server on port {port}, forwarding to {video_host}:{video_port}"
        )
        await server.run()

    asyncio.run(server_main())


@arguably.command
def test(
    *,
    server_host: str = "127.0.0.1",
    server_port: int = 8006,
    source_port: int = 8007,
    image_path: str = "test_images/chair_yes_640.jpg",
):
    """Send test images to the local server for benchmarking

    Args:
        server_host: host address of the analyzer server
        server_port: port of the analyzer server
        source_port: local port to send from
        image_path: path to test image file
    """

    async def test_main():
        from lib.network import UdpSocket
        from lib.network.generated import VideoData, Device

        socket: UdpSocket = await UdpSocket.create(
            port=source_port, device=Device.VISION
        )

        if not os.path.exists(image_path):
            print(f"Error: Image file not found: {image_path}")
            return

        with open(image_path, "rb") as image_file:
            image_data = image_file.read()
        message: VideoData = VideoData()
        message.frame = image_data

        print(f"Sending test image {image_path} to {server_host}:{server_port}")
        socket.send_message(message, (server_host, server_port))
        print("Test image sent successfully")

    asyncio.run(test_main())


@arguably.command
def train(
    *,
    load_from: str = "yolo11s.pt",
    data: str = "perception_v1_dataset/data.yaml",
    epochs: int = 1000,
    img_size: int = 640,
    batch_size: int = 32,
    learning_rate: float = 0.01,
    patience: int = 100,
    validate: bool = True,
):
    """Train a YOLO model on a dataset

    Args:
        load_from: path to existing model file to load from
        data: path to training data YAML file
        epochs: number of training epochs
        img_size: training image size (px)
        batch_size: training batch size
        learning_rate: initial lr
        patience: early stopping patience (epochs without improvement)
        validate: run validation after training
    """
    from lib.trainer import Trainer

    # absolute path so roboflow isnt stupid and looks for the dataset directory?
    if not os.path.isabs(data):
        data = os.path.abspath(data)

    trainer = Trainer(load_from=load_from)

    trainer.train_model(data, epochs, img_size, batch_size, learning_rate, patience)

    if validate:
        print("validation step")
        trainer.validate_model(data)


if __name__ == "__main__":
    arguably.run()
