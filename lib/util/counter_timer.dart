import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CounterTimer {
  Duration counterDuration;
  ValueNotifier<Duration> counterNotifier;
  Timer? _timer;

  CounterTimer({required this.counterDuration}) : counterNotifier = ValueNotifier(counterDuration);

  bool isPlay = false;
  AudioPlayer counterPlayer = AudioPlayer();

  void setCounterTime(Duration seconds) {
    stopTimer();
    counterDuration = seconds;
    counterNotifier.value = counterDuration;
    startTimer();
  }

  void startTimer() {
    if (_timer != null && isPlay) {
      return;
    }
    isPlay = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => tick());
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    isPlay = false;
  }

  Future<void> tick() async {
    final seconds = counterNotifier.value.inSeconds - 1;
    if (seconds < 0) {
      stopTimer();
      counterNotifier.value = counterDuration;
      isPlay = false;
      counterPlayer.play(AssetSource("alert.mp3"));
    } else {
      counterNotifier.value = Duration(seconds: seconds);
    }
  }

  void restartTimer() {
    stopTimer();
    counterNotifier.value = counterDuration;
    startTimer();
  }

  void addSeconds(int seconds) {
    counterNotifier.value = Duration(
      seconds: counterNotifier.value.inSeconds + seconds,
    );
  }

  void dispose() {
    stopTimer();
    counterNotifier.dispose();
  }
}
