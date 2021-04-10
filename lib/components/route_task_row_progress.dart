import 'package:chumaki/models/task.dart';
import 'package:flutter/material.dart';

class RouteTaskRowProgress extends StatelessWidget {
  final RouteTask task;

  RouteTaskRowProgress(this.task);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, data) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${task.from.name}"),
          if (!task.isFinished) Text(task.formatDuration()),
          if (task.isFinished) Text("Прибув!"),
          Text("${task.to.name}")
        ],
      ),
    );
  }
}
