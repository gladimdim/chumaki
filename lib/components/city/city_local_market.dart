import 'package:chumaki/components/bordered_container.dart';
import 'package:chumaki/components/city/city_stock_view.dart';
import 'package:chumaki/components/ui/bordered_top.dart';
import 'package:chumaki/components/wagons/wagon_details.dart';
import 'package:chumaki/components/wagons/wagon_list_item.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:flutter/material.dart';

class CityLocalMarket extends StatefulWidget {
  final City city;

  const CityLocalMarket({required this.city});

  @override
  _CityLocalMarketState createState() => _CityLocalMarketState();
}

class _CityLocalMarketState extends State<CityLocalMarket> {
  Wagon? selectedWagon;
  @override
  void didUpdateWidget(CityLocalMarket old) {
    super.didUpdateWidget(old);
    if (old.city != widget.city ||
        !widget.city.wagons.contains(selectedWagon)) {
      selectedWagon = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selWagon = selectedWagon;
    return StreamBuilder(
      stream: widget.city.changes,
      builder: (context, snapshot) => Column(
        children: [
          Column(
            children: widget.city.wagons.map((wagon) {
              var child = WagonListItem(
                wagon: wagon,
                city: widget.city,
              );

              return TextButton(
                onPressed: () => onWagonSelected(wagon),
                child: selectedWagon == wagon
                    ? BorderedContainer(
                        child: child,
                        color: Colors.blueGrey,
                      )
                    : child,
              );
            }).toList(),
          ),
          if (selWagon != null)
            WagonDetails(wagon: selWagon, city: widget.city),
          // WagonListItem(city: widget.city),
          if (selWagon == null)
            BorderedTop(
              child: CityStockView(
                city: widget.city,
              ),
            ),
        ],
      ),
    );
  }

  void onWagonSelected(Wagon wagon) {
    setState(
      () {
        if (selectedWagon == wagon) {
          selectedWagon = null;
        } else {
          selectedWagon = wagon;
        }
      },
    );
  }
}
