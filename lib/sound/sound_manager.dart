import 'dart:collection';
import 'dart:io';

import 'package:chumaki/models/company.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
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
  };

  Queue<String> _playlist = Queue();
  bool _isPlaying = false;

  Map<String, String> uiActionMapping = {
    "openLocalMarket": "assets/sounds/local_market.mp3",
    "openGlobalMarket": "assets/sounds/global_market.mp3",
    "leaderLevelUp": "assets/sounds/fanfare.mp3",
  };

  Soundpool pool = Soundpool.fromOptions(
      options: SoundpoolOptions(streamType: StreamType.music));

  static final SoundManager instance = SoundManager._internal();

  SoundManager._internal() {}

  // contains ids of loaded sounds
  Map<String, String> sounds = {};

  // Future initSounds() async {
  //   if (sounds.isNotEmpty || Platform.isLinux) {
  //     return;
  //   }
  //   await Future.forEach(
  //     companyActionMapping.keys,
  //     ((element) async {
  //       String? path = companyActionMapping[element];
  //       if (path != null) {
  //         ByteData soundData = await rootBundle.load(path);
  //         int soundId = await pool.load(soundData);
  //         sounds[path] = soundId;
  //       }
  //     }),
  //   );
  //   await Future.forEach(
  //     uiActionMapping.keys,
  //     ((element) async {
  //       String? path = uiActionMapping[element];
  //       if (path != null) {
  //         ByteData soundData = await rootBundle.load(path);
  //         int soundId;
  //         soundId = await pool.load(soundData);
  //         sounds[path] = soundId;
  //       }
  //     }),
  //   );
  // }

  playCompanySound(COMPANY_EVENTS action) {
    queueSound(companyActionMapping[action]);
  }

  attachToCompany(Company company) async {
    // await initSounds();
    company.changes
        .where((event) => companyActionMapping[event] != null)
        .listen((event) {
      playCompanySound(event);
    });
  }

  playUISound(String name) async {
    queueSound(uiActionMapping[name]);
  }

  Future playSoundId(String id) async {
    final player = AudioPlayer();
    final duration = await player.setAsset(id);
    return await player.play();
  }

  void queueSound(String? path) async {
    if (path != null) {
      _playlist.add(path);
    }
    if (!_isPlaying) {
      processQueue();
    }
  }

  void processQueue() async {
    if (_playlist.isEmpty) {
      return;
    } else {
      final nextId = _playlist.removeFirst();
      _isPlaying = true;
      await playSoundId(nextId);
      _isPlaying = false;
      processQueue();
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
}
