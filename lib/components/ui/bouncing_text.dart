import 'package:chumaki/components/ui/bouncing_widget.dart';
import 'package:flutter/material.dart';

class BouncingText extends StatelessWidget {
  final String text;

  const BouncingText(this.text);

  Widget getChild() {
    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(child: getChild(), value: text);
  }
}
