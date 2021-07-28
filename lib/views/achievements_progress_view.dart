import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class AchievementsProgressView extends StatelessWidget {
  final Logger logger;
  const AchievementsProgressView({Key? key, required this.logger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: logger.achievements
          .map((ach) =>
              AchievementProgressView(achievement: ach, logger: logger))
          .toList(),
    );
  }
}

class AchievementProgressView extends StatelessWidget {
  final Achievement achievement;
  final Logger logger;
  const AchievementProgressView(
      {Key? key, required this.achievement, required this.logger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: BorderedAll(
        color: achievement.achieved ? darkGrey : lightGrey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/ui/papyrus_3.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ChumakiLocalizations.getForKey(achievement.localizedKey),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Image.asset(
                      achievement.achieved
                          ? "images/icons/lock/opened_lock.png"
                          : "images/icons/lock/lock2.png",
                      // color: achievement.achieved ? darkGrey : mediumGrey,
                      width: 42,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            achievement.iconPath,
                            width: 128,
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (achievement.boughtResource != null) ...[
                            TitleText(ChumakiLocalizations.labelRequiredToBuy),
                            ResourceImageView(
                              achievement.boughtResource!,
                              size: 32,
                              showAmount: true,
                            ),
                            AchievementProgressBar(
                                achievementTarget: achievement.boughtResource!,
                                stockResource: logger.boughtStock
                                        .resourceInStock(
                                            achievement.boughtResource!) ??
                                    achievement.boughtResource!
                                        .cloneWithAmount(0)),
                          ],
                          if (achievement.soldResource != null) ...[
                            TitleText(ChumakiLocalizations.labelRequiredToSell),
                            ResourceImageView(
                              achievement.soldResource!,
                              size: 32,
                              showAmount: true,
                            ),
                            AchievementProgressBar(
                                achievementTarget: achievement.soldResource!,
                                stockResource: logger.soldStock.resourceInStock(
                                        achievement.soldResource!) ??
                                    achievement.soldResource!
                                        .cloneWithAmount(0)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AchievementProgressBar extends StatelessWidget {
  final Resource achievementTarget;
  final Resource stockResource;
  const AchievementProgressBar({
    Key? key,
    required this.achievementTarget,
    required this.stockResource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = _progressValue();
    return LinearProgressIndicator(
      value: value,
      color: _colorForValue(value),
      semanticsLabel:
          ChumakiLocalizations.getForKey(achievementTarget.fullLocalizedKey),
    );
  }

  Color _colorForValue(double value) {
    if (value < 0.3) {
      return mediumGrey;
    }
    if (value > 0.3 && value < 0.75) {
      return Colors.yellow;
    }
    return darkGrey;
  }

  double _progressValue() {
    final full = achievementTarget.amount;
    final progress = stockResource.amount / full;
    if (progress > 1) {
      return 1;
    }
    return progress;
  }
}
