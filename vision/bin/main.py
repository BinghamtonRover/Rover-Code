import asyncio

from lib.network import UdpSocket
from lib.network.generated import Connect, Device, DriveCommand

def handle_drive(command):
  print(f"Got a command: {command}")

async def main():
  socket = await UdpSocket.create(port=8001, device=Device.SUBSYSTEMS)
  socket.listen("DriveCommand", lambda: DriveCommand(), handle_drive)
  await socket.serve_forever()

asyncio.run(main())
