import 'package:chumaki/extensions/stock.dart';
import 'package:rxdart/rxdart.dart';

class Wagon {
  late Stock stock;
  static final String imagePath = "images/wagon/wagon.png";
  final String name;
  BehaviorSubject changes = BehaviorSubject();

  Wagon({required this.name, Stock? stock}) {
    if (stock == null) {
      this.stock = Stock(List.empty(growable: true));
    } else {
      this.stock = stock;
    }

    this.stock.changes.listen((value) {
      changes.add(value);
    });
  }

  void dispose() {
    changes.close();
  }
}