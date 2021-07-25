import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:flutter/material.dart';

class LoggerStockView extends StatelessWidget {
  final Stock stock;

  const LoggerStockView({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          ChumakiLocalizations.labelLoggerBoughtStats,
          style: Theme.of(context).textTheme.headline6,
        ),
        Column(
          children: stock.stock.map((resource) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/ui/papyrus_1.png"),
                      fit: BoxFit.fill),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ResourceImageView(resource),
                        Text(
                            ChumakiLocalizations.getForKey(
                                resource.fullLocalizedKey),
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                    OutlinedText(
                      resource.amount.toString(),
                      size: 32,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
