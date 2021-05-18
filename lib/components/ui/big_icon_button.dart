import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  final VoidCallback? onPress;
  final Widget image;
  final Widget money;

  const BuyButton(
      {this.onPress, required this.image, required this.money});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 128),
        child: BorderedBottom(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              image,
              money,
              TitleText(ChumakiLocalizations.labelBuy),
            ],
          ),
        ),
      ),
    );
  }
}
