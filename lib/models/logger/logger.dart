import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Logger {
  Logger({required this.boughtStock});

  final Stock boughtStock;

  void cityStockListener(City city, StockEvent event) {
    if (event.item1 != STOCK_EVENTS.REMOVED) {
      return;
    }
    addBoughtResource(event.item2);
  }

  void addBoughtResource(Resource resource) {
    boughtStock.addResource(resource);
  }

  Map<String, dynamic> toJson() {
    return {
      "boughtStock": boughtStock.toJson(),
    };
  }

  static Logger fromJson(Map<String, dynamic> inputJson) {
    return Logger(boughtStock: Stock.fromJson(inputJson["boughtStock"]));
  }
}
