import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/decorated_container.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/utils/share_to.dart';
import 'package:flutter/material.dart';

const toolbarIconsSize = 42.0;

class AchievementCardView extends StatelessWidget {
  final AchievementBase achievement;
  final Widget content;

  AchievementCardView(
      {Key? key, required this.achievement, required this.content})
      : super(key: key);

  GlobalKey _shareKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _shareKey,
      child: Padding(
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
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          ResizedImage(
                            achievement.achieved
                                ? "images/icons/lock/opened_lock.png"
                                : "images/icons/lock/lock2.png",
                            // color: achievement.achieved ? darkGrey : mediumGrey,
                            width: toolbarIconsSize,
                          ),
                          GameText(
                              ChumakiLocalizations.getForKey(
                                  achievement.localizedKey),
                              addStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        ],
                      ),
                      Wrap(
                        children: [
                          if (achievement.achieved)
                            SizedBox(
                              width: toolbarIconsSize,
                              height: toolbarIconsSize,
                              child: DDDButton(
                                onPressed: () async {
                                  await TwitterShareTo().launch(
                                      ChumakiLocalizations.getForKey(
                                          achievement.localizedKey));
                                },
                                color: mediumGrey,
                                shadowColor: Theme.of(context).backgroundColor,
                                child: ResizedImage(
                                  "images/twitter_icon.png",
                                  width: toolbarIconsSize / 2,
                                ),
                              ),
                            ),
                          SizedBox(
                            width: toolbarIconsSize,
                            height: toolbarIconsSize,
                            child: DDDButton(
                                onPressed: () async {
                                  await ShareImage.shareWidgetImageAtKey(
                                    _shareKey,
                                    getAchievementTextForShare(achievement),
                                  );
                                },
                                color: mediumGrey,
                                shadowColor: Theme.of(context).backgroundColor,
                                child: Icon(Icons.share,
                                    size: toolbarIconsSize / 2)),
                          ),
                        ],
                      ),
                      // if (achievement.achieved)
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
      ),
    );
  }

  String getAchievementTextForShare(AchievementBase achievement) {
    String achName = ChumakiLocalizations.getForKey(achievement.localizedKey);
    String prefix = ChumakiLocalizations.labelMyAchievementProgress;
    String suffix = ChumakiLocalizations.labelShortGameDescription;
    return "$prefix: '$achName'. $suffix";
  }
}
