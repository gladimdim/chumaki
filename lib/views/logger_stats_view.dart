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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "images/wagon/cart.png",
                            width: 64,
                          ),
                        ),
                        Text(
                            "${ChumakiLocalizations.labelWagonsBought}: ${logger.boughtWagons}"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "images/leaders/leader4.png",
                            width: 64,
                          ),
                        ),
                        Text(
                            "${ChumakiLocalizations.labelLeadersHired}: ${logger.leadersHired}"),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "images/leaders/leader1.png",
                            width: 64,
                          ),
                        ),
                        Text(
                            "${ChumakiLocalizations.labelCompletedCityEvents}: ${logger.completedCityEvents}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              ChumakiLocalizations.labelLoggerBoughtStats,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            LoggerStockView(stock: logger.boughtStock),
            Text(
              ChumakiLocalizations.labelLoggerSoldStats,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            LoggerStockView(stock: logger.soldStock),
            Text(
              ChumakiLocalizations.labelAchievements,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            AchievementsProgressView(logger: logger),
          ],
        ),
      ),
    );
  }
}
