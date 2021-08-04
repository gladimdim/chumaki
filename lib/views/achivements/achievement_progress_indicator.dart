import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class AchievementProgressIndicator extends StatelessWidget {
  final double value;

  const AchievementProgressIndicator(
      {Key? key, required this.value, r})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      color: _colorForValue(value),
    );
  }

  Color _colorForValue(double value) {
    if (value < 0.3) {
      return mediumGrey;
    }
    if (value > 0.3 && value < 0.75) {
      return Colors.yellow;
    }
    return darkGrey;
  }
}
