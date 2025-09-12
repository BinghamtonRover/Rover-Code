#!/usr/bin/env python3
import arguably
import asyncio
import os


@arguably.command
def unit_test(
        *, 
        images_dir: str = "test_images", 
        load_from: str = "yolo11s.pt",
):
    """Test how a model does on test images

    Args:
        load_from: path to existing model file to load from
        images_dir: directory containing test images
    """
    import cv2
    from lib.analyzer import ImageAnalyzer

    analyzer = ImageAnalyzer(load_from=load_from)
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
        result, confidence = analyzer.has_mallet(frame)
        if result == has_mallet:
            passed += 1
            print(f"{background} image passed -- {result} (confidence: {confidence:.3f})")
        else:
            failed += 1
            print(
                f"{background} image failed: Analyzer detected {result} instead of {has_mallet} (confidence: {confidence:.3f})"
            )

    print(f"Results: {passed} passed, {failed} failed")


@arguably.command
def test(
    *,
    server_host: str = "127.0.0.1",
    server_port: int = 8006,
    source_port: int = 8007,
    recv_port: int = 8002,
    stream: str = "cam",
    image_size: int = 640,
    jpg_quality: int = 60,
):
    """Send frames from a video stream to the server

    Args:
        server_host: host address of the analyzer server
        server_port: port of the analyzer server
        source_port: local port to send from
        recv_port: port to listen on for server's responses
        stream: the video stream from which frames are sent to the server ("cam" | "screen")
        image_size: resize frames to this size before sending (px)
        jpg_quality: JPEG compression quality (1-100)
    """
    def handle_frame(data):
        import cv2
        import numpy as np

        if not data.frame:
            return

        print("recieved frame from server")

        buffer = np.asarray(bytearray(data.frame), dtype="uint8")
        matrix = cv2.imdecode(buffer, cv2.IMREAD_COLOR)
        
        cv2.imshow("Annotated", matrix)
        
    async def test_main():
        from lib.network import UdpSocket
        from lib.network.generated import VideoData, Device
        from lib.video_stream import VideoStream, WebcamStream, ScreenStream
        import cv2

        v_stream: VideoStream = None

        if stream not in ["cam", "screen"]:
            print("""'--stream' argument can only be one of "cam", "screen".""")
            print("Continuing with '--stream cam'")

        if stream == "cam":
            v_stream = WebcamStream()
        else:
            monitor = {"left": 0, "top": 0, "height": 1000, "width": 1000}
            v_stream = ScreenStream(monitor)
            
        socket: UdpSocket = await UdpSocket.create(
            port=recv_port, device=Device.VISION
        )
        # listen for sent back frames
        socket.listen("VideoData", VideoData, handle_frame)

        while True:
            await asyncio.sleep(1.0/120)
            frame = v_stream.get_cv_frame()
            if frame is None:
                print(f"Failed to get frame from video stream {stream}")
                continue
            
            frame_resized = cv2.resize(frame, (image_size, image_size))
            
            success, jpg = cv2.imencode(
                '.jpg', frame_resized, [cv2.IMWRITE_JPEG_QUALITY, jpg_quality]
            )
            if not success:
                print("Failed to encode frame as JPEG")
                continue
            
            message: VideoData = VideoData()
            message.frame = bytes(jpg)

            cv2.waitKey(1)

            socket.send_message(message, (server_host, server_port))

    asyncio.run(test_main())


@arguably.command
def server(
    *,
    load_from: str = "yolo11s.pt",
    port: int = 8006,
    video_host: str = "127.0.0.1",
    video_port: int = 8002,
    jpg_quality: int = 60,
    max_packet_size: int = 60000,
    show: str = "none",
):
    """Start the analyzer server

    Args:
        load_from: path to existing model file to load from
        port: port to listen on for incoming frames
        video_host: host to send annotated frames to
        video_port: port to send annotated frames to
        jpg_quality: JPEG compression quality (1-100)
        max_packet_size: maximum UDP packet size in bytes
        show: display recieved frames in a window ("none" | "before" | "after")
    """

    async def server_main():
        nonlocal show
        from lib.analyzer import ImageAnalyzer
        from lib.analyzer_server import AnalyzerServer
        from lib.network import UdpSocket
        from lib.network.generated import Device

        socket = await UdpSocket.create(port=port, device=Device.VISION)
        analyzer = ImageAnalyzer(load_from=load_from)
        video_dest = (video_host, video_port)

        if show not in ["none", "before", "after"]:
            print("""'--show' argument can only be one of "none", "before", or "after".""")
            print("Consider this a warning buddy.. \nContinuing with '--show none'")
            show = "none"

        server = AnalyzerServer(
            socket, analyzer, jpg_quality, max_packet_size, video_dest, show
        )
        print(
            f"starting analyzer server on port {port}, sending to {video_host}:{video_port}"
        )
        await server.run()

    asyncio.run(server_main())


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
