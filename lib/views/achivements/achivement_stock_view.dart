import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/achievement_stock.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/views/achivements/achievement_card_view.dart';
import 'package:chumaki/views/achivements/achievement_stock_progress_bar.dart';
import 'package:flutter/material.dart';

class AchievementStockView extends StatelessWidget {
  final AchievementStock achievement;
  final Logger logger;

  const AchievementStockView(
      {Key? key, required this.achievement, required this.logger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AchievementCardView(
      achievement: achievement,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (achievement.boughtResource != null) ...[
              GameText(ChumakiLocalizations.labelRequiredToBuy),
              ResourceImageView(
                achievement.boughtResource!,
                size: 32,
                showAmount: true,
              ),
              AchievementStockProgressBar(
                  achievementTarget: achievement.boughtResource!,
                  stockResource: logger.boughtStock
                          .resourceInStock(achievement.boughtResource!) ??
                      achievement.boughtResource!.cloneWithAmount(0)),
            ],
            if (achievement.soldResource != null) ...[
              GameText(ChumakiLocalizations.labelRequiredToSell),
              ResourceImageView(
                achievement.soldResource!,
                size: 32,
                showAmount: true,
              ),
              AchievementStockProgressBar(
                  achievementTarget: achievement.soldResource!,
                  stockResource: logger.soldStock
                          .resourceInStock(achievement.soldResource!) ??
                      achievement.soldResource!.cloneWithAmount(0)),
            ],
          ],
        ),
      ),
    );
  }
}
