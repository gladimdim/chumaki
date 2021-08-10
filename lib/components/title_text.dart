import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  TitleText(this.text, {this.style});

  @override
  Widget build(BuildContext context) {
    final realStyle = gameTextStyle.merge(style);
    return Text(
      text,
      style: Theme.of(context).textTheme.headline5!.merge(realStyle),
    );
  }
}
