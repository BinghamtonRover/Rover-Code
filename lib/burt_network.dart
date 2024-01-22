/// The shared Dart networking library.
/// 
/// We use [UDP](https://en.wikipedia.org/wiki/User_Datagram_Protocol) to send data to and from 
/// the rover. In order to sync our data between languages, we use [Protobuf](https://protobuf.dev/).
/// Because UDP is inherently unsafe, we have a "heartbeat" and "handshake" protocol. 
/// 
/// This library offers several classes to help use UDP sockets consistently: 
/// 
/// - [UdpSocket] is a raw UDP socket that allows sending and receiving lists of bytes.
/// - [ProtoSocket] is a layer on top of [UdpSocket] that translates bytes to Protobuf messages.
/// - [BurtUdpProtocol] extends [ProtoSocket] to handle special messages like heartbeats.
/// - [RoverHeartbeats] extends [BurtUdpProtocol] to respond to the dashboard's heartbeats.
/// - [RoverLogger] extends [BurtUdpProtocol] by buffering logs until the dashboard connects.
/// - [RoverServer] combines [RoverHeartbeats] and [RoverLogger] to handle all on-rover needs.
/// 
/// On the rover, use [RoverServer]. On the dashboard, extend [BurtUdpProtocol]. To use these classes, 
/// extend them and override the suggested methods in their respective documentation. You should
/// not have to use [UdpSocket] directly as it has no Protobuf support.
library;

// For doc comments:
import "src/burt_protocol.dart";
import "src/proto_socket.dart";
import "src/rover_heartbeats.dart";
import "src/rover_logger.dart";
import "src/rover_server.dart";
import "src/udp_socket.dart";

export "src/proto_socket.dart";
export "src/rover_server.dart";
export "src/burt_protocol.dart";
export "src/rover_heartbeats.dart";
export "src/socket_info.dart";
export "src/udp_socket.dart";

export "generated.dart";
