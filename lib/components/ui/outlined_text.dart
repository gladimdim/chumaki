import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;

  final Color? fontColor;
  final Color? outlineColor;
  final double? size;

  const OutlinedText(this.text,
      {this.fontColor, this.outlineColor, this.size = 16});

  @override
  Widget build(BuildContext context) {
    var outColor =
        outlineColor == null ? Theme.of(context).primaryColor : outlineColor;
    var fColor =
        fontColor == null ? Theme.of(context).backgroundColor : fontColor;
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = outColor!,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: fColor!,
          ),
        ),
      ],
    );
  }
}
