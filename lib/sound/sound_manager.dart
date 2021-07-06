import 'dart:collection';

import 'package:chumaki/models/company.dart';
import 'package:just_audio/just_audio.dart';

class SoundManager {
  // do not forget to modify this map in web sounds manager implementation
  Map<COMPANY_EVENTS, String> companyActionMapping = {
    COMPANY_EVENTS.CITY_UNLOCKED: "assets/sounds/cart_bought.mp3",
    COMPANY_EVENTS.TASK_STARTED: "assets/sounds/marching_cossacks.mp3",
    COMPANY_EVENTS.TASK_ENDED: "assets/sounds/done.mp3",
    COMPANY_EVENTS.MONEY_ADDED: "assets/sounds/money.mp3",
    COMPANY_EVENTS.WAGON_BOUGHT: "assets/sounds/cart_bought.mp3",
    COMPANY_EVENTS.LEADER_HIRED: "assets/sounds/write_on_paper.mp3",
    COMPANY_EVENTS.EVENT_DONE: "assets/sounds/achievement.mp3",
  };
  Queue<String> _playlist = Queue();
  bool _isPlaying = false;

  final AudioPlayer _player = AudioPlayer();
  Map<String, String> uiActionMapping = {
    "openLocalMarket": "assets/sounds/local_market.mp3",
    "openGlobalMarket": "assets/sounds/global_market.mp3",
    "leaderLevelUp": "assets/sounds/fanfare.mp3",
  };

  static final SoundManager instance = SoundManager._internal();

  SoundManager._internal() {}

  playCompanySound(COMPANY_EVENTS action) {
    queueSound(companyActionMapping[action]);
  }

  attachToCompany(Company company) async {
    company.changes
        .where((event) => companyActionMapping[event] != null)
        .listen((event) {
      playCompanySound(event);
    });
  }

  playUISound(String name) async {
    queueSound(uiActionMapping[name]);
  }

  Future playQueuedSound() async {
    if (_playlist.isEmpty) {
      return;
    }
    final nextTrack = _playlist.removeFirst();
    _isPlaying = true;
    await _player.setAsset(nextTrack);
    await _player.play();
    await _player.stop();
    _isPlaying = false;
    playQueuedSound();
  }

  void queueSound(String? track) {
    if (track == null) {
      return;
    }
    if (_playlist.isNotEmpty) {
      return;
    }

    _playlist.add(track);
    if (!_isPlaying) {
      playQueuedSound();
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
