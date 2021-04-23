import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onPressed;
  final Widget child;

  SelectableButton(
      {required this.selected, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: selected ? BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ) : null,
      child: TextButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
