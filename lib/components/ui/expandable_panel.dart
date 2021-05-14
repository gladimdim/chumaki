import 'dart:math';

import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:flutter/material.dart';

class ExpandablePanel extends StatefulWidget {
  final Widget title;
  final Widget content;

  ExpandablePanel({
    required this.title,
    required this.content,
  });

  @override
  _ExpandablePanelState createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late final AnimationController _rotateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
      lowerBound: 0.0,
      upperBound: 1.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AnimatedSize(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BorderedBottom(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.title,
                  AnimatedBuilder(
                    animation: _rotateController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: pi * _rotateController.value,
                        child: child,
                      );
                    },
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: toggleExpanded,
                    ),
                  ),
                ],
              ),
            ),
            // if (isExpanded)
            AnimatedCrossFade(
              firstChild: Container(height: 0.0),
              secondChild: widget.content,
              firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
              secondCurve:
                  const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
              sizeCurve: Curves.fastOutSlowIn,
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 800),
            ),
          ],
        ),
      ),
    );
  }

  void toggleExpanded() {
    setState(() {
      if (isExpanded) {
        _rotateController.reverse();
      } else {
        _rotateController.forward();
      }
      isExpanded = !isExpanded;
    });
  }
}
