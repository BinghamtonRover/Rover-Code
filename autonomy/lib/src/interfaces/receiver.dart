mixin Receiver {
  bool hasValue = false;
  
  Future<void> waitForValue() async {
    while (!hasValue) {
      await Future<void>.delayed(const Duration(seconds: 1));
    }
  }
}
