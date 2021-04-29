import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;

  BorderedContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 3.0,
          ),
        ),
        child: child);
  }
}
