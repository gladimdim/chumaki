import 'dart:math';

import 'package:chumaki/models/routes/route_task.dart';
import 'package:flutter/material.dart';

class AnimatedRouteTask extends StatefulWidget {
  final RouteTask task;

  AnimatedRouteTask(this.task);

  @override
  _AnimatedRouteTaskState createState() => _AnimatedRouteTaskState();
}

class _AnimatedRouteTaskState extends State<AnimatedRouteTask>
    with SingleTickerProviderStateMixin {
  bool started = false;
  late final AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    double upper = 2 * pi;
    double lower = 0;
    _rotateController =
        AnimationController(vsync: this, upperBound: upper, lowerBound: lower)
          ..duration = widget.task.duration;

    _rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateController.repeat();
      }
    });
    Future.delayed(Duration(milliseconds: 20), () {
      setState(() {
        started = true;
        _rotateController.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var first = widget.task.from;
    var second = widget.task.to;
    var rotation = second.point.x < first.point.x ? -1 : 1;
    return AnimatedPositioned(
      key: Key(widget.task.id),
      duration: widget.task.duration!,
      left: started ? second.point.x : first.point.x,
      top: started ? second.point.y : first.point.y,
      child: SizedBox(
        width: 50,
        height: 50,
        child: AnimatedBuilder(
          animation: _rotateController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotateController.value * rotation,
              child: child,
            );
          },
          child: Image.asset("images/wagon/wheel.png"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }
}
