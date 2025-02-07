import "dart:ffi";
import "package:subsystems/src/generated/can_ffi_bindings.dart";

export "dart:ffi";
export "package:ffi/ffi.dart";
export "package:subsystems/src/generated/can_ffi_bindings.dart";

/// The native SocketCAN-based library.
///
/// See `src/can.h` in this repository. Only supported on Linux.
final nativeLib = CanBindings(DynamicLibrary.open("burt_can.so"));

/// Helpful methods on [BurtCanStatus].
extension BurtCanStatusUtils on BurtCanStatus {
  /// A human-readable string representing this error, if any.
  String? get stringError => switch (this) {
    BurtCanStatus.OK => null,
    BurtCanStatus.SOCKET_CREATE_ERROR => "Could not create socket",
    BurtCanStatus.INTERFACE_PARSE_ERROR => "Could not parse interface",
    BurtCanStatus.BIND_ERROR => "Could not bind to socket",
    BurtCanStatus.CLOSE_ERROR => "Could not close socket",
    BurtCanStatus.MTU_ERROR => "Invalid MTU",
    BurtCanStatus.CANFD_NOT_SUPPORTED => "CAN FD is not supported",
    BurtCanStatus.FD_MISC_ERROR => "Could not switch to CAN FD",
    BurtCanStatus.WRITE_ERROR => "Could not write data",
    BurtCanStatus.READ_ERROR => "Could not read data",
    BurtCanStatus.FRAME_NOT_FULLY_READ => "Frame was not fully read",
  };
}
