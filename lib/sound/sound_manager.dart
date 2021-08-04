import 'dart:async';

import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:io';

class SoundManager {
  // do not forget to modify this map in web sounds manager implementation
  Map<COMPANY_EVENTS, String> companyActionMapping = {
    COMPANY_EVENTS.CITY_UNLOCKED: "assets/sounds/cart_bought.mp3",
    COMPANY_EVENTS.TASK_STARTED: "assets/sounds/marching_cossacks.mp3",
    COMPANY_EVENTS.TASK_ENDED: "assets/sounds/done.mp3",
    COMPANY_EVENTS.MONEY_ADDED: "assets/sounds/money.mp3",
    COMPANY_EVENTS.WAGON_BOUGHT: "assets/sounds/cart_bought.mp3",
    COMPANY_EVENTS.LEADER_HIRED: "assets/sounds/write_on_paper.mp3",
    COMPANY_EVENTS.CITY_EVENT_DONE: "assets/sounds/achievement.mp3",
  };

  Map<String, String> uiActionMapping = {
    "openLocalMarket": "assets/sounds/local_market.mp3",
    "openGlobalMarket": "assets/sounds/global_market.mp3",
    "leaderLevelUp": "assets/sounds/fanfare.mp3",
  };

  StreamSubscription? _sub;
  StreamSubscription? _loggerSub;

  static final SoundManager instance = SoundManager._internal();

  SoundManager._internal() {}

  playCompanySound(COMPANY_EVENTS action) {
    queueSound(companyActionMapping[action]);
  }

  attachToCompany(Company company) {
    _sub = company.changes
        .where((event) => companyActionMapping[event] != null)
        .listen((event) {
      playCompanySound(event);
    });

    _loggerSub = company.logger.changes
        .where((event) => event == LOGGER_EVENTS.ACHIEVEMENT_UNLOCKED)
        .listen((event) {
      playLeaderLevelUp();
    });
  }

  detachFromCompany() {
    _sub?.cancel();
    _loggerSub?.cancel();
  }

  playUISound(String name) async {
    queueSound(uiActionMapping[name]);
  }

  bool isSoundSupport() {
    return Platform.isMacOS || Platform.isIOS || Platform.isAndroid || kIsWeb;
  }

  void queueSound(String? track) async {
    if (track == null ||
        !AppPreferences.instance.getIsSoundEnabled() ||
        !isSoundSupport()) {
      return;
    }

    final player = AudioPlayer();
    await player.setAsset(track);
    await player.play();
    await player.stop();
    await player.dispose();
  }

  void playLocalMarket() {
    playUISound("openLocalMarket");
  }

  void playGlobalMarket() {
    playUISound("openGlobalMarket");
  }

  void playLeaderLevelUp() {
    playUISound("leaderLevelUp");
  }
}
