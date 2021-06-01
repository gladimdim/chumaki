import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPress;
  final Widget image;
  final Widget subTitle;
  final Widget action;

  const ActionButton(
      {this.onPress,
      required this.image,
      required this.subTitle,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return BorderedAll(
      child: TextButton(
        onPressed: onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            image,
            subTitle,
            action,
          ],
        ),
      ),
    );
  }
}
