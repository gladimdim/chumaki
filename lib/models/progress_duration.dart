import 'dart:async';

import 'package:chumaki/utils/time.dart';
import 'package:clock/clock.dart';
import 'package:rxdart/rxdart.dart';

enum PROGRESS_DURACTION_EVENTS { STARTED, FINISHED, ACTIVE }

class ProgressDuration {
  DateTime? finishAt;
  Duration? duration;
  bool isStarted = false;
  bool isFinished = false;

  BehaviorSubject<PROGRESS_DURACTION_EVENTS> _innerChanges = BehaviorSubject();
  late ValueStream<PROGRESS_DURACTION_EVENTS> changes;
  late Timer _timer;

  ProgressDuration(this.duration) {
    changes = _innerChanges.stream;
  }

  ProgressDuration.empty() {
    changes = _innerChanges.stream;
  }

  double leftProgress() {
    var f = finishAt!.toUtc().millisecondsSinceEpoch;
    var start = f - duration!.inMilliseconds;

    var now = clock.now();
    if (now.compareTo(finishAt!) > 0) {
      return 1;
    }

    var full = f - start;
    var passed = now.millisecondsSinceEpoch - start;
    return passed / full;
  }

  Duration leftDurationProgress() {
    return finishAt!.difference(clock.now());
  }

  void start() {
    var current = clock.now();
    finishAt = current.add(duration!);
    isStarted = true;
    _innerChanges.add(PROGRESS_DURACTION_EVENTS.STARTED);
    initTimer();
  }

  void adjustDurationToFinishAt() {
    duration = finishAt!.difference(clock.now());
  }

  initTimer() {
    _timer = Timer(duration!, () {
      if (isDone()) {
        isFinished = true;
        _innerChanges.add(PROGRESS_DURACTION_EVENTS.FINISHED);
        _innerChanges.close();
      } else {
        _innerChanges.add(PROGRESS_DURACTION_EVENTS.ACTIVE);
      }
    });
  }

  bool isDone() {
    return finishAt != null && clock.now().compareTo(finishAt!) >= 0;
  }

  String formatDuration() {
    return readableDuration(leftDurationProgress());
  }

  ///
  ///JSON
  ///

  Map<String, dynamic> toJson() {
    return {
      "isStarted": isStarted,
      "isFinished": isFinished,
      "finishAt": finishAt?.millisecondsSinceEpoch,
      "duration": duration!.inSeconds,
    };
  }

  static ProgressDuration fromJson(Map<String, dynamic> json) {
    var duration = ProgressDuration(Duration(seconds: json["duration"]))
      ..isFinished = json["isFinished"]
      ..isStarted = json["isStarted"];
    var finishAt = json["finishAt"];
    if (finishAt != null) {
      duration.finishAt = DateTime.fromMillisecondsSinceEpoch(json["finishAt"]);
      if (duration.isDone()) {
        duration.isFinished = true;
      } else {
        duration.adjustDurationToFinishAt();
      }
      if (duration.isStarted && !duration.isFinished) {
        duration.start();
      }
    }

    return duration;
  }

  void dispose() {
    _timer.cancel();
    if (!_innerChanges.isClosed) {
      _innerChanges.close();
    }
  }
}
