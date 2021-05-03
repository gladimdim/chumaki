import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class MoneyUnit extends StatelessWidget {
  final Money money;
  MoneyUnit(this.money);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(money.imagePath, width: 32),
        Text(money.amount.toStringAsFixed(1), style: style(money.amount),)
      ],
    );
  }

  TextStyle style(double value) {
    return TextStyle(color: value > 0 ? Colors.green[800] : Colors.red[800], fontWeight: FontWeight.bold, fontSize: 18);
  }
}
