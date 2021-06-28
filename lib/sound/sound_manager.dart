import 'package:chumaki/models/company.dart';
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
  };

  int? currentSoundId;

  Map<String, String> uiActionMapping = {
    "openLocalMarket": "assets/sounds/local_market.mp3",
    "openGlobalMarket": "assets/sounds/global_market.mp3",
  };

  Soundpool pool = Soundpool.fromOptions(
      options: SoundpoolOptions(streamType: StreamType.music));

  static final SoundManager instance = SoundManager._internal();

  // contains ids of loaded sounds
  Map<String, int> sounds = {};

  SoundManager._internal() {}

  Future initSounds() async {
    if (sounds.isNotEmpty) {
      return;
    }
    await Future.forEach(
      companyActionMapping.keys,
      ((element) async {
        String? path = companyActionMapping[element];
        if (path != null) {
          ByteData soundData = await rootBundle.load(path);
          int soundId;
          soundId = await pool.load(soundData);
          sounds[path] = soundId;
        }
      }),
    );
    await Future.forEach(
      uiActionMapping.keys,
      ((element) async {
        String? path = uiActionMapping[element];
        if (path != null) {
          ByteData soundData = await rootBundle.load(path);
          int soundId;
          soundId = await pool.load(soundData);
          sounds[path] = soundId;
        }
      }),
    );
  }

  playCompanySound(COMPANY_EVENTS action) async {
    await playSoundId(sounds[companyActionMapping[action]]);
  }

  attachToCompany(Company company) async {
    await initSounds();
    company.changes
        .where((event) => companyActionMapping[event] != null)
        .listen((event) {
        playCompanySound(event);
    });
  }

  playUISound(String name) async {
    playSoundId(sounds[uiActionMapping[name]]);
  }

  Future playSoundId(int? id) async {
    if (currentSoundId != null) {
      await pool.stop(currentSoundId!);
    }
    currentSoundId = id;
    if (currentSoundId != null) {
      await pool.play(currentSoundId!);
    }
  }

  void playLocalMarket() {
    playUISound("openLocalMarket");
  } void playGlobalMarket() {
    playUISound("openGlobalMarket");
  }

}
