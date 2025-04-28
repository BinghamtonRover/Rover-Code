# Sends test images to the local server for benchmarking and testing purposes

import asyncio
from lib.network import UdpSocket
from lib.network.generated import VideoData, Device

async def main():
    socket: UdpSocket = await UdpSocket.create(port=8007, device=Device.VISION)

    test_img_path: str = "../test_images/chair_yes_640_480.jpg"
    with open(test_img_path, "rb") as image_file:
        image_data = image_file.read()

    message: VideoData = VideoData()

    message.frame = image_data

    socket.send_message(message, ("127.0.0.1", 8006))
    

if __name__ == "__main__":
    asyncio.run(main())