import 'dart:async';

import 'package:chumaki/components/leader/add_new_perk_view.dart';
import 'package:chumaki/components/leader/leader_avatar.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bouncing_outlined_text.dart';
import 'package:chumaki/components/ui/disappear.dart';
import 'package:chumaki/components/ui/perk_unit_view.dart';
import 'package:chumaki/components/ui/scale_animated.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:flutter/material.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

class LeaderView extends StatefulWidget {
  final Leader leader;

  const LeaderView(this.leader);

  @override
  State<LeaderView> createState() => _LeaderViewState();
}

class _LeaderViewState extends State<LeaderView> {
  final double _progressWidth = 200;
  late final StreamSubscription _leaderSub;
  final GlobalKey<PageFlipBuilderState> avatarFlipper = GlobalKey();
  @override
  void initState() {
    super.initState();
    _leaderSub = widget.leader.changes
        .where((event) => event == LEADER_CHANGES.LEVEL_UP)
        .listen(onLeaderLevelUp);
  }

  @override
  Widget build(BuildContext context) {
    final experience = widget.leader.experience % widget.leader.levelDelta;
    return StreamBuilder(
      stream: widget.leader.changes,
      builder: (context, _) => SizedBox(
        height: 80,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageFlipBuilder(
                  nonInteractiveAnimationDuration: Duration(seconds: 1),
                  key: avatarFlipper,
                  backBuilder: (BuildContext context) {
                    return LeaderAvatar(leader: widget.leader);
                  },
                  frontBuilder: (BuildContext context) {
                    return LeaderAvatar(leader: widget.leader);
                  },
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TitleText(ChumakiLocalizations.labelLevel),
                      BouncingOutlinedText(
                        widget.leader.level.toString(),
                        size: 24,
                        fontColor: Theme.of(context).primaryColor,
                        outlineColor: Theme.of(context).backgroundColor,
                      ),
                    ],
                  ),
                ),
                if (widget.leader.availablePerks == 0)
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TitleText(ChumakiLocalizations.labelListOfPerks),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.leader.perks
                                .map((perk) => PerkUnitView(perk))
                                .toList()),
                      ],
                    ),
                  ),
                if (widget.leader.availablePerks > 0)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleText(
                              "${ChumakiLocalizations.labelAvailablePerks}: "),
                          BouncingOutlinedText(
                              widget.leader.availablePerks.toString(),
                              size: 24),
                        ],
                      ),
                      AddNewPerkView(
                        widget.leader,
                      ),
                    ],
                  ),
                Expanded(
                  flex: 2,
                  child: widget.leader.hasReachedMaxLevel()
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TitleText(ChumakiLocalizations.labelExperience),
                            SizedBox(
                              width: _progressWidth,
                              height: 30,
                              child: BorderedAll(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: experience /
                                            widget.leader.levelDelta *
                                            _progressWidth,
                                        height: 30,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: BouncingOutlinedText(
                                        "$experience/${widget.leader.levelDelta}",
                                        fontColor: Colors.yellow,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
            StreamBuilder<LEADER_CHANGES>(
                stream: widget.leader.changes
                    .where((event) => event == LEADER_CHANGES.LEVEL_UP),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ScaleAnimated(
                      key: ValueKey(widget.leader.level),
                      duration: Duration(milliseconds: 700),
                      child: Disappear(
                        duration: Duration(seconds: 3),
                        key: ValueKey(widget.leader.level),
                        child: Align(
                          child: Text(ChumakiLocalizations.labelLeveledUp,
                              style: Theme.of(context).textTheme.headline2),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }

  void onLeaderLevelUp(LEADER_CHANGES event) {
    if (event == LEADER_CHANGES.LEVEL_UP) {
      SoundManager.instance.playLeaderLevelUp();
      avatarFlipper.currentState?.flip();
    }
  }

  @override
  void dispose() {
    _leaderSub.cancel();
    super.dispose();
  }
}
