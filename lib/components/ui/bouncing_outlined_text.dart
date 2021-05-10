import 'package:chumaki/components/ui/bouncing_text.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:flutter/material.dart';

class BouncingOutlinedText extends BouncingText {
  final String text;
  const BouncingOutlinedText(this.text) : super(text);

  Widget getChild() => OutlinedText(text);
}
