import "dart:typed_data";

/// Arm serial envelope: A5 5A, uint16 little-endian payload length, protobuf bytes.
Uint8List frameFirmwareMessage(Uint8List payload) {
  if (payload.isEmpty || payload.length > 2048) throw ArgumentError("Invalid arm frame length");
  return Uint8List.fromList([0xa5, 0x5a, payload.length & 255, payload.length >> 8, ...payload]);
}

/// Reassembles split USB reads and separates multiple frames in the same read.
class FirmwareFrameDecoder {
  final _buffer = <int>[];
  /// Discard partial data when opening or resetting the connection.
  void reset() => _buffer.clear();
  /// Return complete protobuf payloads, retaining any unfinished frame.
  List<Uint8List> add(Uint8List bytes) {
    _buffer.addAll(bytes);
    final output = <Uint8List>[];
    while (_buffer.length >= 2) {
      if (_buffer[0] != 0xa5 || _buffer[1] != 0x5a) { _buffer.removeAt(0); continue; }
      if (_buffer.length < 4) break;
      final length = _buffer[2] | (_buffer[3] << 8);
      if (length == 0 || length > 2048) { _buffer.removeAt(0); continue; }
      if (_buffer.length < length + 4) break;
      output.add(Uint8List.fromList(_buffer.sublist(4, 4 + length)));
      _buffer.removeRange(0, 4 + length);
    }
    return output;
  }
}
