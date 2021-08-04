import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/decorated_container.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class AchievementCardView extends StatelessWidget {
  final AchievementBase achievement;
  final Widget content;
  const AchievementCardView({Key? key, required this.achievement, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: BorderedAll(
        color: achievement.achieved ? darkGrey : lightGrey,
        child: DecoratedContainer3(
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
                    child: content,
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
