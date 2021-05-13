import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class MoneyUnitView extends StatelessWidget {
  final Money money;
  final bool isEnough;
  MoneyUnitView(this.money, {this.isEnough = true});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Image.asset(money.imagePath, width: 32),
        Text(money.amount.toStringAsFixed(1), style: style(money.amount, context),)
      ],
    );
  }

  TextStyle style(double value, BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return TextStyle(color: isEnough  ? Colors.green[800] : colorTheme.onSurface.withOpacity(0.38), fontWeight: FontWeight.bold, fontSize: 18);
  }
}
