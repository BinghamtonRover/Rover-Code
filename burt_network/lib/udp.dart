/// The shared Dart networking library.
///
/// We use [UDP](https://en.wikipedia.org/wiki/User_Datagram_Protocol) to send data to and from
/// the rover. In order to sync our data between languages, we use [Protobuf](https://protobuf.dev/).
/// Because UDP is inherently unsafe, we have a "heartbeat" and "handshake" protocol.
///
/// This library offers several classes to help use UDP sockets consistently:
///
/// - [UdpSocket] is a raw UDP socket that allows sending and receiving lists of bytes.
/// - [BurtSocket] uses a [UdpSocket] to add Protobuf, heartbeats, and settings.
/// - [RoverHeartbeats] extends [BurtSocket] to respond to the dashboard's heartbeats.
/// - [RoverLogger] extends [BurtSocket] by buffering logs until the dashboard connects.
/// - [RoverSocket] combines [RoverHeartbeats] and [RoverLogger] to handle all on-rover needs.
///
/// On the rover, use [RoverSocket]. On the dashboard, extend [BurtSocket]. To use these classes,
/// extend them and override the suggested methods in their respective documentation. You should
/// not have to use [UdpSocket] directly as it has no Protobuf support.
library;

// For doc comments:
import "src/udp/burt_socket.dart";
import "src/udp/rover_heartbeats.dart";
import "src/udp/rover_logger.dart";
import "src/udp/rover_socket.dart";
import "src/udp/udp_socket.dart";

export "src/udp/burt_socket.dart";
export "src/udp/rover_socket.dart";
export "src/udp/rover_settings.dart";
export "src/udp/rover_heartbeats.dart";
export "src/udp/rover_timesync.dart";
export "src/udp/socket_info.dart";
export "src/udp/udp_socket.dart";
export "src/udp/timesync_socket.dart";
export "src/udp/timesync_server.dart";
