import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class ActionText extends Text {
  final String text;
  final TextStyle? addStyle;

  ActionText(this.text, {Key? key, this.addStyle})
      : super(
          text,
          key: key,
          style: addStyle == null
              ? actionTextStyle
              : addStyle.merge(actionTextStyle),
        );
}
