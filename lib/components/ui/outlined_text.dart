import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  const OutlinedText(this.text);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.white,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
