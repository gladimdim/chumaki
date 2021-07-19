import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/resources/resource.dart';

class Logger {
  Stock stockLogger = Stock([]);

  void logBuyStock(Resource resource) {
    stockLogger.addResource(resource);
    print(stockLogger.stock.first.amount);
  }
}
