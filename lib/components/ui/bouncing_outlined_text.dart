import 'package:chumaki/components/ui/bouncing_text.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:flutter/material.dart';

class BouncingOutlinedText extends BouncingText {
  final String text;
  final double? size;
  final Color? fontColor;
  final Color? outlineColor;

  const BouncingOutlinedText(this.text,
      {this.size, this.fontColor, this.outlineColor})
      : super(text);

  Widget getChild() => OutlinedText(
        text,
        size: size,
        fontColor: fontColor,
        outlineColor: outlineColor,
      );
}
