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
/// - [ServerSocket] is a [ProtoSocket] that can respond to heartbeats and monitors its connection.
/// 
/// On the rover, use [ServerSocket]. On the dashboard, use [ProtoSocket]. To use these classes, 
/// extend them and override the suggested methods in their respective documentation. You should
/// not have to use [UdpSocket] directly as it has no Protobuf support.
library;

import "src/proto_socket.dart";
import "src/server_socket.dart";
import "src/udp_socket.dart";

export "src/proto_socket.dart";
export "src/server_socket.dart";
export "src/socket_info.dart";
export "src/udp_socket.dart";

export "generated.dart";
export "logging.dart";
