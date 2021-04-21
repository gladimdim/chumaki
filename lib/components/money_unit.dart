import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';

class MoneyUnit extends StatelessWidget {
  final Money money;
  final Axis direction;
  MoneyUnit(this.money, {this.direction = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Row(
        children: [
          Image.asset(money.imagePath, width: 32),
          Text(money.amount.toStringAsFixed(1), style: style(money.amount),)
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset(money.imagePath, width: 32),
          Text(money.amount.toStringAsFixed(1), style: style(money.amount),)
        ],
      );
    }
  }

  TextStyle style(double value) {
    return TextStyle(color: value > 0 ? Colors.green[800] : Colors.red[800], fontWeight: FontWeight.bold, fontSize: 18);
  }
}
