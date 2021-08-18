import 'dart:async';
import 'dart:io';

import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

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
    COMPANY_EVENTS.DONATED_TO_EVENT: "assets/sounds/paper_moved.mp3",
  };

  Map<String, String> uiActionMapping = {
    "openLocalMarket": "assets/sounds/local_market.mp3",
    "openGlobalMarket": "assets/sounds/global_market.mp3",
    "leaderLevelUp": "assets/sounds/fanfare.mp3",
    "buildingBuilt": "assets/sounds/building_upgrade.mp3",
  };

  StreamSubscription? _sub;
  StreamSubscription? _loggerSub;
  List<StreamSubscription> _citiesSubs = [];

  static final SoundManager instance = SoundManager._internal();

// contains ids of loaded sounds
  Map<String, int> sounds = {};

  SoundManager._internal() {}

  Future initSounds() async {
    if (kIsWeb || Platform.isWindows || Platform.isLinux) {
      return;
    } else {
      pool = Soundpool.fromOptions(
          options: SoundpoolOptions(streamType: StreamType.music));
    }
    if (sounds.isNotEmpty) {
      return;
    }
    await initSoundsForMap(uiActionMapping);
    await initSoundsForMap(companyActionMapping);
  }

  Future initSoundsForMap(Map map) async {
    await Future.forEach(
      map.keys,
      ((element) async {
        String? path = map[element];
        if (path != null) {
          ByteData soundData = await rootBundle.load(path);
          int soundId;
          soundId = await pool.load(soundData);
          sounds[path] = soundId;
        }
      }),
    );
  }

  late Soundpool pool;

  playCompanySound(COMPANY_EVENTS action) {
    queueSound(companyActionMapping[action]);
  }

  attachToCompany(Company company) {
    _sub = company.changes
        .where((event) => companyActionMapping[event.item1] != null)
        .listen((event) {
      playCompanySound(event.item1);
    });

    _loggerSub = company.logger.changes
        .where((event) => event == LOGGER_EVENTS.ACHIEVEMENT_UNLOCKED)
        .listen((event) {
      playLeaderLevelUp();
    });

    company.allCities.forEach((city) {
      final sub = city.changes
          .where((event) =>
              [CITY_EVENTS.MFG_BUILT, CITY_EVENTS.MFG_UPGRADED].contains(event))
          .listen((event) {
        playBuildingBuilt();
      });
      _citiesSubs.add(sub);
    });
  }

  detachFromCompany() {
    _sub?.cancel();
    _loggerSub?.cancel();
    _citiesSubs.forEach((element) => element.cancel());
  }

  playUISound(String name) async {
    queueSound(uiActionMapping[name]);
  }

  void queueSound(String? track) async {
    if (track == null || !AppPreferences.instance.getIsSoundEnabled()) {
      return;
    }

    int? id = sounds[track];
    if (id == null) {
      return;
    } else {
      await pool.play(id);
    }
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

  void playBuildingBuilt() {
    playUISound("buildingBuilt");
  }

  void playNewEvent() {
    playUISound("leaderLevelUp");
  }
}
