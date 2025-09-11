import cv2
import numpy as np
from lib.analyzer import ImageAnalyzer
from lib.network.generated import VideoData


class AnalyzerServer:
    def __init__(
        self,
        socket,
        analyzer,
        jpg_quality=60,
        max_packet_size=60000,
        video_dest=("127.0.0.1", 8002),
    ):
        self.analyzer = analyzer
        self.socket = socket
        self.jpg_quality = jpg_quality
        self.max_packet_size = max_packet_size
        self.video_dest = video_dest
        self.socket.listen("VideoData", VideoData, self.handle_frame)

    def handle_frame(self, data):
        if not data.frame:
            return

        buffer = np.asarray(bytearray(data.frame), dtype="uint8")
        matrix = cv2.imdecode(buffer, cv2.IMREAD_COLOR)
        frame = self.analyzer.annotateImage(matrix)

        success, jpg = cv2.imencode(
            ".jpg", frame, [cv2.IMWRITE_JPEG_QUALITY, self.jpg_quality]
        )
        if not success:
            return
        data = VideoData(frame=bytes(jpg), details=data.details)

        jpg_size = len(jpg)
        if jpg_size > self.max_packet_size:
            print(
                f"WARNING: Frame was too large to send over UDP ({jpg_size} bytes). If this happens too often, change the JPG_QUALITY"
            )
            return

        self.socket.send_message(data, destination=self.video_dest)

    async def run(self):
        await self.socket.serve_forever()
