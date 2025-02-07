import "dart:convert";
import "dart:typed_data";

import "package:collection/collection.dart";
import "package:osc/osc.dart";

/// Frame end
const end = 192;

/// Frame esc
const esc = 219;

/// Transposed frame end
const escEnd = 220;

/// Transposed frame escape
const escEsc = 221;

/// The bytes of the OSC message #bundle header
final bundleHeader = const Utf8Encoder().convert("#bundle");

/// Parses an OSC bundle from a list of bytes.
OSCMessage? parseOsc(List<int> data) {
  try {
    List<int> buffer;
    // If multiple messages are sent at once, it won't have the #bundle header
    final hasHeader = data.length > bundleHeader.length
      && data.sublist(0, bundleHeader.length).equals(bundleHeader);
    if (hasHeader) {
      // skip 8 byte "#bundle" + 8 byte timestamp + 4 byte data length
      buffer = data.sublist(20);
    } else {
      buffer = data;
    }
    return OSCMessage.fromBytes(buffer);
  } catch (error) {
    /* Ignore corrupt data */
    return null;
  }
}

/// This [SLIP](https://en.wikipedia.org/wiki/Serial_Line_Internet_Protocol) codec.
///
/// This converter is here until `package:osc` supports SLIP, mandated by the OSC v1.1 spec.
/// See this issue: https://github.com/pq/osc/issues/24
class SlipCodec extends Codec<List<int>, List<int>> {
  @override
  SlipEncoder get encoder => SlipEncoder();

  @override
  SlipDecoder get decoder => SlipDecoder();
}

/// Adds bytes as specified the SLIP protocol.
class SlipEncoder extends Converter<List<int>, List<int>> {
  @override
  List<int> convert(List<int> input) {
    final newPacket = <int>[];
    for (final element in input) {
      if (element == end) {
        newPacket.addAll([esc, escEnd]);
      } else if (element == esc) {
        newPacket.addAll([esc, escEsc]);
      } else {
        newPacket.add(element);
      }
    }
    newPacket.add(end);
    return newPacket;
  }
}

/// Removes bytes inserted by the SLIP protocol.
class SlipDecoder extends Converter<List<int>, List<int>> {
  @override
  List<int> convert(List<int> input) {
    final newPacket = <int>[];
    var prevElement = 0;
    for (final element in input) {
      if (prevElement == esc && element == escEnd) {
        newPacket.last = end;  // ESC + ESC_END -> END
      } else if (prevElement == esc && element == escEsc) {
        newPacket.last = esc;  // ESC + ESC_ESC -> ESC
      } else {
        newPacket.add(element);
      }
      prevElement = element;
    }
    if (newPacket.last == end) newPacket.removeLast();
    return newPacket;
  }
}

/// Helpful methods on lists of bytes.
extension ListToUint8List on List<int> {
  /// Converts to a more efficient [Uint8List].
  Uint8List toUint8List() => Uint8List.fromList(this);
}

/// The global SLIP codec.
final slip = SlipCodec();
