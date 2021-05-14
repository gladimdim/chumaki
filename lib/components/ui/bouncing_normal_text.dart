import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bouncing_text.dart';
import 'package:flutter/material.dart';

class BouncingNormalText extends BouncingText {
  final String text;

  const BouncingNormalText(this.text) : super(text);

  Widget getChild() {
    return TitleText(text);
  }
}