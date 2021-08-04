import 'package:flutter/material.dart';

class AchievementProgressIndicator extends StatelessWidget {
  final double value;
  final Color color;

  const AchievementProgressIndicator(
      {Key? key, required this.value, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      color: color,
    );
  }
}
