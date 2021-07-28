import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/decorated_container.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/views/achievements_progress_view.dart';
import 'package:chumaki/views/logger_stock_view.dart';
import 'package:flutter/material.dart';

class LoggerStatsView extends StatelessWidget {
  final Logger logger;
  final VoidCallback onClose;
  const LoggerStatsView({Key? key, required this.logger, required this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer3(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: onClose, icon: Icon(Icons.close)),
                TitleText(ChumakiLocalizations.labelGameStats),
                IconButton(onPressed: onClose, icon: Icon(Icons.close)),
              ],
            ),
            DecoratedContainer2(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "images/wagon/cart.png",
                          width: 64,
                        ),
                        TitleText(
                            "Ви купили стільки возів: ${logger.boughtWagons}"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Ви найняли лідерів: ${logger.leadersHired}"),
                  ),
                ],
              ),
            ),
            Text(
              ChumakiLocalizations.labelLoggerBoughtStats,
              style: Theme.of(context).textTheme.headline6,
            ),
            LoggerStockView(stock: logger.boughtStock),
            Text(
              ChumakiLocalizations.labelLoggerSoldStats,
              style: Theme.of(context).textTheme.headline6,
            ),
            LoggerStockView(stock: logger.soldStock),
            Text(
              ChumakiLocalizations.labelAchievements,
              style: Theme.of(context).textTheme.headline6,
            ),
            AchievementsProgressView(logger: logger),
          ],
        ),
      ),
    );
  }
}
