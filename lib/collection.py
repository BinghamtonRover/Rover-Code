from analyzer import ImageAnalyzer

from network import *
from lib.network.generated import Connect, Device, DriveCommand, VideoData

class Collection:
	async def __init__(self, *args, **kwds):
		self.analyzer = ImageAnalyzer()
		self.socket = await UdpSocket.create(port=8001, device=Device.SUBSYSTEMS)
		# TODO: Implement a way to handle the frame
		self.socket.listen("Frame", lambda: VideoData(), self.handle_frame)

	def handle_frame(self, frame):
		frame = self.analyzer.annotateImage(frame)
		# TODO: Implement a way to send the frame
		#self.socket.send(frame)

	def run(self):
		self.socket.serve_forever()