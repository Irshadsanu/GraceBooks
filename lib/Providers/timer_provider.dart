
import 'package:flutter/foundation.dart';
import 'dart:async';
class TimeProvider extends ChangeNotifier {
  int _countdown = 60; // Initial countdown time in seconds
  Timer? _timer;

  int get countdown => _countdown;

  void startCountdown() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_countdown > 0) {
          _countdown--;
          notifyListeners();
        } else {
          _timer?.cancel();
          _timer = null;
        }
      });
  }

  void resetCountdown() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    _countdown = 60; // Reset the countdown time
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
