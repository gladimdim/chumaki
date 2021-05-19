import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class ActionMoneyButton extends StatelessWidget {
  final VoidCallback? onPress;
  final Widget image;
  final Widget money;
  final Widget action;

  const ActionMoneyButton(
      {this.onPress, required this.image, required this.money, required this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 128),
        child: BorderedAll(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              image,
              money,
              action,
            ],
          ),
        ),
      ),
    );
  }
}
