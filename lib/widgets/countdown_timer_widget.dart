//https://www.flutterbeads.com/flutter-countdown-timer/#:~:text=Steps%20to%20add%20countdown%20timer,()%20to%20restart%20the%20timer.

import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimerWidget extends StatefulWidget {
  final int minutes;
  final int seconds;
  final Function? onFinished;
  final TextStyle? textStyle;

  const CountDownTimerWidget({
    Key? key,
    this.minutes = 0,
    this.seconds = 0,
    this.onFinished,
    this.textStyle,
  }) : super(key: key);

  @override
  State<CountDownTimerWidget> createState() => _CountDownTimerWidgetState();
}

class _CountDownTimerWidgetState extends State<CountDownTimerWidget> {
  Timer? countdownTimer;
  Duration myDuration = const Duration();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      startTimer();
    });
  }

  void startTimer() {
    setState(() => myDuration =
        Duration(minutes: widget.minutes, seconds: widget.seconds));

    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();

    setState(() => myDuration =
        Duration(minutes: widget.minutes, seconds: widget.seconds));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        if (widget.onFinished != null) widget.onFinished!();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Text(
      '$minutes:$seconds',
      style: widget.textStyle,
    );
  }
}
