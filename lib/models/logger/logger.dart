import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';

class Logger {
  Logger();
  final Stock boughtStock = Stock([]);

  void cityStockListener(City city, StockEvent event) {
    if (event.item1 != STOCK_EVENTS.REMOVED) {
      return;
    }

    boughtStock.addResource(event.item2);
  }
}
