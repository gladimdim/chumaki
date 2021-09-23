import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class GameText extends Text {
  final String text;
  final TextStyle? addStyle;

  GameText(this.text, {Key? key, this.addStyle})
      : super(text,
            key: key,
            style: addStyle == null
                ? gameTextStyle
                : addStyle.merge(gameTextStyle));
}

class GameSelectableText extends SelectableText {
  final String text;
  final TextStyle? addStyle;

  GameSelectableText(this.text, {Key? key, this.addStyle})
      : super(text,
      key: key,
      style: addStyle == null
          ? gameTextStyle
          : addStyle.merge(gameTextStyle));
}