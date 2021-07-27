import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class AchievementsProgressView extends StatelessWidget {
  final List<Achievement> achievements;
  const AchievementsProgressView({Key? key, required this.achievements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: achievements
          .map((ach) => AchievementProgressView(achievement: ach))
          .toList(),
    );
  }
}

class AchievementProgressView extends StatelessWidget {
  final Achievement achievement;
  const AchievementProgressView({Key? key, required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: BorderedAll(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/ui/papyrus_3.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    ChumakiLocalizations.getForKey(achievement.localizedKey),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Icon(
                    achievement.achieved ? Icons.lock_open : Icons.lock_clock,
                    color: achievement.achieved ? darkGrey : mediumGrey,
                    size: 42,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Image.asset(achievement.iconPath, width: 128)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (achievement.boughtResource != null) ...[
                          TitleText("Required to buy: "),
                          ResourceImageView(achievement.boughtResource!,
                              showAmount: true),
                        ],
                        if (achievement.soldResource != null) ...[
                          TitleText("Required to sell: "),
                          ResourceImageView(achievement.soldResource!,
                              showAmount: true),
                        ],
                      ],
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
