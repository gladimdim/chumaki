import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final Color? color;
  final Widget child;

  BorderedContainer({required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    var c = color;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: c != null ? c : Theme.of(context).primaryColor,
            width: 3.0,
          ),
        ),
        child: child);
  }
}
