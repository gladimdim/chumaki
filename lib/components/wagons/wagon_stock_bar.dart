import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:flutter/material.dart';

class WagonStockBar extends StatelessWidget {
  final Wagon wagon;
  final double _stockContainerHeight = 75.0;
  final double _maxWidth =
      CITY_DETAILS_VIEW_WIDTH - CITY_DETAILS_VIEW_WIDTH / 4 - 2;

  WagonStockBar({required this.wagon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GameText(
          ChumakiLocalizations.labelWagonContains,
          addStyle: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: _stockContainerHeight,
          child: BorderedAll(
            child: Row(
              children: wagon.stock.iterator.map<Widget>(
                (res) {
                  return SizedBox(
                    width: res.totalWeight * (_maxWidth / 100),
                    child: Stack(
                      children: [
                        Container(
                          width: res.totalWeight * (_maxWidth / 100),
                          height: _stockContainerHeight,
                          color: res.color,
                        ),
                        if (res.totalWeight > 10)
                          Align(
                            alignment: Alignment.center,
                            child: ResourceImageView(
                              res,
                              size: 54,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
