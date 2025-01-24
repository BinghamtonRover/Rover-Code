import "dart:typed_data";

import "ffi.dart";

/// A wrapper around a [NativeCanMessage].
/// 
/// This class allows you to handle CAN frames allocated natively, or allocate them yourself.
/// When allocating natively, use [CanMessage()]. When receiving a pointer to [NativeCanMessage], 
/// use [CanMessage.fromPointer]. 
/// 
/// Be sure to call [dispose] when you're done with the message. Once disposed, the fields of this
/// class will return garbage data or segfault, so you should be careful to only dispose when you
/// are truly done with the message.
class CanMessage implements Finalizable {
  /// Guarantees that native resources are freed.
  /// 
  /// NOTE: This does not call free native resources allocated by Dart. Use [dispose] for that.
  static final _finalizer = NativeFinalizer(nativeLib.addresses.NativeCanMessage_free.cast());
  /// The pointer to the [NativeCanMessage] struct backing this object.
  final Pointer<NativeCanMessage> pointer;

  /// Whether the resources were allocated by Dart or natively, which deteremines how to [dispose].
  final bool isNative;

  /// The length of the message.
  int get length => _isDisposed ? throw StateError("Message is disposed") : pointer.ref.length;

  /// The ID of the message.
  int get id => _isDisposed ? throw StateError("Message is disposed") : pointer.ref.id;

  /// Allows you to access a native `char*` as a [Uint8List].
  List<int> get data => _isDisposed ? throw StateError("Message is disposed") : pointer.ref.data.asTypedList(length);

  bool _isDisposed = false;

  /// Allocates a [NativeCanMessage] and holds a reference to its [pointer].
  factory CanMessage({required int id, required List<int> data}) {
    final pointer = calloc<NativeCanMessage>();
    final buffer = data.toNativeBuffer();
    pointer.ref.id = id;
    pointer.ref.data = buffer.cast();
    pointer.ref.length = data.length;
    return CanMessage.fromPointer(pointer, isNative: false);
  }

  /// Stores a reference to a [NativeCanMessage] and where it was allocated.
  CanMessage.fromPointer(this.pointer, {required this.isNative}) {
    if (isNative) _finalizer.attach(this, pointer.cast(), detach: this);
  }

  /// Frees the [CanMessage] struct that was natively allocated.
  void dispose() {
    if (isNative) {
      nativeLib.NativeCanMessage_free(pointer);
    } else {
      calloc.free(pointer.ref.data);
      calloc.free(pointer);
    }
    _finalizer.detach(this);
    _isDisposed = true;
  }
}

extension on List<int> {
  /// Copies a list of bytes in Dart into a newly-allocated`char*`, which must be freed.
  Pointer<Uint8> toNativeBuffer() {
    final buffer = calloc<Uint8>(length);
    for (int i = 0; i < length; i++) {
      buffer[i] = this[i];
    }
    return buffer;
  }
}
