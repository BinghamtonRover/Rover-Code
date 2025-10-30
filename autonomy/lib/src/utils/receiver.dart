import "dart:async";

mixin Receiver {
  final Completer<bool> _completer = Completer<bool>();

  bool _hasValue = false;

  set hasValue(bool value) {
    _hasValue = value;
    if (!value) return;
    if (!_completer.isCompleted) {
      _completer.complete(true);
    }
  }

  bool get hasValue => _hasValue;

  Future<void> waitForValue() => _completer.future;
}
