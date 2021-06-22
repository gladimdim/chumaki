import 'dart:math';

import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:flutter/material.dart';

class ExpandablePanel extends StatefulWidget {
  final Widget title;
  final Widget content;
  final bool isUnlocked;

  ExpandablePanel({
    required this.title,
    required this.content,
    this.isUnlocked = true,
  });

  @override
  _ExpandablePanelState createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  final Duration defaultDuration = Duration(milliseconds: 400);
  late final AnimationController _rotateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
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
        duration: defaultDuration,
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BorderedBottom(
              child: TextButton(
                onPressed: widget.isUnlocked ? toggleExpanded : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 5, child: widget.title),
                    Expanded(
                      flex: 1,
                      child: AnimatedBuilder(
                        animation: _rotateController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: pi * _rotateController.value,
                            child: child,
                          );
                        },
                        child: IconButton(
                          icon: Icon(widget.isUnlocked ? Icons.arrow_downward : Icons.lock, color: Colors.black,),
                          onPressed: widget.isUnlocked ? toggleExpanded : null,
                        ),
                      ),
                    ),
                  ],
                ),
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
              duration: defaultDuration,
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

  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }
}
