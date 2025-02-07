import asyncio
import cv2
import numpy as np

from lib.analyzer import ImageAnalyzer
from lib.network import *
from lib.network.generated import *

videoSocket = ("127.0.0.1", 8002)
MAX_UDP_PACKET_SIZE = 60_000
JPG_QUALITY = 60

class AnalyzerServer:
	def __init__(self, socket, analyzer):
		self.analyzer = analyzer
		self.socket = socket
		self.socket.listen("VideoData", VideoData, self.handle_frame)

	def handle_frame(self, data):
		if not data.frame: return
		# Decode the image from a JPG to an OpenCV matrix
		buffer = np.asarray(bytearray(data.frame), dtype="uint8")
		matrix = cv2.imdecode(buffer, cv2.IMREAD_COLOR)

		# Analyze and annotate the frame
		# TODO: Get detection data as well
		frame = self.analyzer.annotateImage(matrix)

		# Encode the image back to a JPG and send it back
		success, jpg = cv2.imencode(".jpg", frame, [cv2.IMWRITE_JPEG_QUALITY, JPG_QUALITY])
		if not success: return
		data = VideoData(frame=bytes(jpg), details=data.details)

		# UDP specifies a max packet size of 65,536 bytes
		# Images captured by the video program will never exceed this limit, as they too
		# were sent over UDP. However, annotating the frame might increase the size again,
		# so we compress to 60% to avoid a packet that's too big. The occasional packet
		# may be too big, so we log that. If the warning shows up often, the quality should
		# be lowered even further to compensate.
		jpg_size = len(jpg)
		if jpg_size > MAX_UDP_PACKET_SIZE:
			print(f"WARNING: Frame was too large to send over UDP ({jpg_size} bytes). If this happens too often, change the JPG_QUALITY")
			return

		# The Dashboard only recognizes specific devices that participate in heartbeats.
		# This program can be added to that list, but in the short-term, we send back to video
		# which forwards it to the Dashboard for us.
		self.socket.send_message(data, destination=videoSocket)

	async def run(self):
		await self.socket.serve_forever()

	def cleanup(self):
		self.socket.close()

async def main():
	socket = await UdpSocket.create(port=8006, device=Device.VISION)
	analyzer = ImageAnalyzer()
	server = AnalyzerServer(socket, analyzer)
	await server.run()

if __name__ == "__main__":
	asyncio.run(main())
