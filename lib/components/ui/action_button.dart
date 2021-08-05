import 'dart:async';

import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final VoidCallback? onPress;
  final Widget image;
  final Widget subTitle;
  final Widget action;
  final Duration tickPeriod;
  final int speedUpAfter;
  const ActionButton(
      {this.onPress,
      required this.image,
      required this.subTitle,
      this.speedUpAfter = 5,
      this.tickPeriod = const Duration(milliseconds: 400),
      required this.action});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Timer? _timer;
  int _execCount = 0;
  bool _wasSpeedup = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      child: BorderedAll(
        child: TextButton(
          onPressed: widget.onPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              widget.image,
              widget.subTitle,
              widget.action,
            ],
          ),
        ),
      ),
    );
  }

  void onLongPressStart(_) {
    if (widget.onPress == null) {
      return;
    }
    _timer = Timer.periodic(widget.tickPeriod, tickerCallback);
  }

  void tickerCallback(timer) {
    _execCount++;
    if (!_wasSpeedup && _execCount >= widget.speedUpAfter) {
      _wasSpeedup = true;
      timer.cancel();
      _timer = Timer.periodic(widget.tickPeriod * 0.3, tickerCallback);
      return;
    }
    widget.onPress!();
  }

  void onLongPressEnd(_) {
    _execCount = 0;
    _wasSpeedup = false;
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
