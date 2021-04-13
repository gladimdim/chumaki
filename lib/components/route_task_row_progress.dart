import 'dart:math';

import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/models/task.dart';
import 'package:flutter/material.dart';

class RouteTaskRowProgress extends StatelessWidget {
  final RouteTask task;

  RouteTaskRowProgress(this.task);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(milliseconds: 33)),
      builder: (context, data) => Row(
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
                      ),),
                  ),
                  if (task.isFinished) Text("Прибув!"),
                  if (!task.isFinished) Positioned(
                    left: 200 * task.leftProgress(),
                    child: Transform.rotate(
                      angle: 2 * pi * task.leftProgress(),
                      child: Image.asset("images/wagon/cart_64.png", width: 32),
                    ),
                  ),
                  Positioned(
                    top: 32,
                    // left: 200 * task.leftProgress(),
                    left: 100,
                    child: task.isFinished ? Text("") : Text(
                      task.formatDuration(),
                    ),
                  )
                ],
              ),
            ),
          Expanded(
            flex: 3,
            child: Text(
              "${task.to.name}",
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
