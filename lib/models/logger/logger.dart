import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';

class Logger {
  Logger(
      {required this.boughtStock,
      this.boughtWagons = 0,
      required this.soldStock});

  final Stock boughtStock;
  final Stock soldStock;
  int boughtWagons;

  void attachToCompany(Company company) {
    company.changes
        .where((event) => event == COMPANY_EVENTS.WAGON_BOUGHT)
        .listen((_) => wagonListener());

    company.allCities.forEach((city) {
      city.stock.changes.listen(cityStockListener);
    });
  }

  void cityStockListener(StockEvent event) {
    switch (event.item1) {
      case STOCK_EVENTS.ADDED:
        addSoldStock(event.item2);
        break;

      case STOCK_EVENTS.REMOVED:
        addBoughtResource(event.item2);
        break;
    }
  }

  void wagonListener() {
    boughtWagons++;
  }

  void addBoughtResource(Resource resource) {
    boughtStock.addResource(resource);
  }

  void addSoldStock(Resource resource) {
    soldStock.addResource(resource);
  }

  Map<String, dynamic> toJson() {
    return {
      "boughtStock": boughtStock.toJson(),
      "ownedWagons": boughtWagons,
      "soldStock": soldStock.toJson(),
    };
  }

  static Logger fromJson(Map<String, dynamic> inputJson) {
    return Logger(
      boughtStock: Stock.fromJson(
        inputJson["boughtStock"],
      ),
      boughtWagons: inputJson["ownedWagons"],
      soldStock: Stock.fromJson(inputJson["soldStock"]),
    );
  }
}
