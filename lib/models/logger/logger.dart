import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';

class Logger {
  Logger({required this.boughtStock, this.boughtWagons = 0});

  final Stock boughtStock;
  int boughtWagons;

  void attachToCompany(Company company) {
    company.changes
        .where((event) => event == COMPANY_EVENTS.WAGON_BOUGHT)
        .listen((_) => wagonListener());
    company.allCities.forEach((city) {
      city.stock.changes
          .where((event) => event.item1 == STOCK_EVENTS.REMOVED)
          .listen(cityStockListener);
    });
  }

  void cityStockListener(StockEvent event) {
    addBoughtResource(event.item2);
  }

  void wagonListener() {
    boughtWagons++;
  }

  void addBoughtResource(Resource resource) {
    boughtStock.addResource(resource);
  }

  Map<String, dynamic> toJson() {
    return {
      "boughtStock": boughtStock.toJson(),
      "ownedWagons": boughtWagons,
    };
  }

  static Logger fromJson(Map<String, dynamic> inputJson) {
    return Logger(
      boughtStock: Stock.fromJson(
        inputJson["boughtStock"],
      ),
      boughtWagons: inputJson["ownedWagons"],
    );
  }
}
