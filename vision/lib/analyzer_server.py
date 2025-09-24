import asyncio
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
        show="none",
    ):
        self.analyzer = analyzer
        self.socket = socket
        self.jpg_quality = jpg_quality
        self.max_packet_size = max_packet_size
        self.video_dest = video_dest
        self.show = show
        self.socket.listen("VideoData", VideoData, self.handle_frame)

    def handle_frame(self, data):
        if not data.frame:
            return

        print("recieved frame")

        buffer = np.asarray(bytearray(data.frame), dtype="uint8")
        matrix = cv2.imdecode(buffer, cv2.IMREAD_COLOR)
        
        if self.show == "before":
            cv2.imshow("Rover Vision Server (before annotation)", matrix)
        
        frame = self.analyzer.annotateImage(matrix)
        
        if self.show == "after":
            cv2.imshow("Rover Vision Server (after annotation)", frame)

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

        print("sending back frame")
        self.socket.send_message(data, destination=self.video_dest)

    async def _keep_show_window_alive(self):
        while True:
            cv2.waitKey(1)
            await asyncio.sleep(0.01)

    async def run(self):
        if self.show not in ["none", "before", "after"]:
            print("""'--show' argument can only be one of "none", "before", or "after".""")
            print("Consider this a warning buddy.. \nContinuing with '--show none'")
            self.show = "none"

        tasks = [self.socket.serve_forever()]
        
        if self.show != "none":
            tasks.append(self._keep_show_window_alive())
        
        await asyncio.gather(*tasks)
