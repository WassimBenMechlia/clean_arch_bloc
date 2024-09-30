import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  bool isRunning = false;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      return;
    }
    isRunning = true;
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      isRunning = false;
      action();
      _timer = null;
    });
  }
}
