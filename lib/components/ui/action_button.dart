import 'dart:async';

import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final VoidCallback? onPress;
  final Widget image;
  final Widget subTitle;
  final Widget action;
  final bool longPressSupport;
  final Duration longPressTick;
  final int speedUpAfter;
  const ActionButton({
    this.onPress,
    required this.image,
    required this.subTitle,
    required this.action,
    this.longPressTick = const Duration(milliseconds: 400),
    this.speedUpAfter = 10,
    this.longPressSupport = false,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Timer? _timer;
  int _execCount = 0;
  bool _hasSpeedUp = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: widget.longPressSupport ? onLongPressStart: null,
      onLongPressEnd: widget.longPressSupport ?  onLongPressEnd : null,
      child: BorderedAll(
        child: TextButton(
          onPressed: () {
            if (widget.onPress != null) {
              widget.onPress!();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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

  void onLongPressStart(details) {
    if (widget.onPress == null) {
      return;
    }
    _timer = Timer.periodic(widget.longPressTick, _timerCallback);
  }

  void _timerCallback(timer) {
    final callback = widget.onPress;
    if (callback == null) {
      _timer?.cancel();
      return;
    }
    callback();
    _execCount++;
    if (!_hasSpeedUp && _execCount >= widget.speedUpAfter ) {
      _timer?.cancel();
      _hasSpeedUp = true;
      _timer = Timer.periodic(widget.longPressTick * 0.2, _timerCallback);
    }
  }

  void onLongPressEnd(details) {
    _execCount = 0;
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
