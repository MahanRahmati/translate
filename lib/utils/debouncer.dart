import 'dart:async';

import 'package:arna/arna.dart';

class Debouncer {
  Debouncer({
    required this.milliseconds,
    this.action,
  });

  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
