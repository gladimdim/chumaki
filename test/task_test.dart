import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/routes/route_task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Task object", () {
    RouteTask task = RouteTask(
      Nizhin(),
      Kyiv(),
      wagon: Wagon(),
    );
    RouteTask newTask = RouteTask.fromJson(task.toJson());
    setUp(() {
      task = RouteTask(
        Nizhin(),
        Kyiv(),
        wagon: Wagon(),
      );
      newTask = RouteTask.fromJson(task.toJson());
    });

    test("Can serialize/deserialize Task object", () {
      expect(newTask.to.equalsTo(task.to), isTrue,
          reason: "To City was restored");
      expect(newTask.from.equalsTo(task.from), isTrue,
          reason: "From City was restored");
      expect(
          newTask.wagon, isNotNull,
          reason: "Wagon was restored");
      expect(newTask.finishAt, equals(task.finishAt),
          reason: "Finish at is restored");
      expect(newTask.isStarted, isFalse, reason: "isStarted is restored");
      expect(newTask.isFinished, isFalse, reason: "isFinished is restored");
    });

    test("Can serialize active task", () {
      task.start();
      final activeTask = RouteTask.fromJson(task.toJson());
      expect(activeTask.isStarted, isTrue,
          reason: "Task is started restored: true");
      expect(activeTask.isFinished, isFalse,
          reason: "Task is finished restored: false");
    });

    test("Can restore streams", () {
      FakeAsync().run((async) {
        var finishedSent = false;
        task.duration = Duration(seconds: 2);
        task.start();
        RouteTask newTask = RouteTask.fromJson(task.toJson());
        newTask.changes.listen((event) {
          if (event == PROGRESS_DURACTION_EVENTS.FINISHED) {
            finishedSent = true;
          }
        });
        async.elapse(Duration(seconds: 1));
        async.flushMicrotasks();
        expect(newTask.isStarted, isTrue);
        expect(finishedSent, isFalse);
        async.elapse(Duration(seconds: 2));
        async.flushMicrotasks();
        expect(finishedSent, isTrue);
      });
    });
  });
}
