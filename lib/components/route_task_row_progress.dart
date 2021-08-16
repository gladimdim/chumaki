import 'dart:math';

import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/tasks/route_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RouteTaskRowProgress extends StatefulWidget {
  final RouteTask task;
  final City forCity;

  RouteTaskRowProgress(this.task, this.forCity);

  @override
  State<RouteTaskRowProgress> createState() => _RouteTaskRowProgressState();
}

class _RouteTaskRowProgressState extends State<RouteTaskRowProgress>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              Container(
                width: 200,
                height: 64,
              ),
              Positioned(
                top: 32,
                left: 0,
                child: Container(
                  width: 200,
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
              ),
              if (widget.task.isFinished) Text("Прибув!"),
              if (!widget.task.isFinished)
                Positioned(
                  left: calculateRelativePositionForProgress(),
                  child: Transform.rotate(
                    angle: 2 * pi * widget.task.leftProgress(),
                    child: ResizedImage("images/wagon/wheel.png", width: 32),
                  ),
                ),
              Positioned(
                top: 32,
                // left: 200 * task.leftProgress(),
                left: 100,
                child: widget.task.isFinished
                    ? Text("")
                    : Text(
                        widget.task.formatDuration(),
                      ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            ltr() ? "${widget.task.to.localizedKeyName}" : "${widget.task.from.localizedKeyName}",
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  bool ltr() {
    return widget.forCity == widget.task.from;
  }

  calculateRelativePositionForProgress() {
    return ltr()
        ? 200 * widget.task.leftProgress()
        : (200 - 200 * widget.task.leftProgress());
  }

  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
