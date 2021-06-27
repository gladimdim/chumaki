import 'package:chumaki/models/company.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundManager {
  // do not forget to modify this map in web sounds manager implementation
  Map<COMPANY_EVENTS, String> actionMapping = {
    COMPANY_EVENTS.CITY_UNLOCKED: "assets/sounds/cart_bought.mp3",
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
      actionMapping.keys,
      ((element) async {
        String? path = actionMapping[element];
        if (path != null) {
          ByteData soundData = await rootBundle.load(path);
          int soundId;
          soundId = await pool.load(soundData);
          sounds[path] = soundId;
        }
      }),
    );
  }

  playSound(COMPANY_EVENTS action) async {
    final soundId = sounds[actionMapping[action]];
    if (soundId != null) {
      await pool.play(soundId);
    }
  }

  attachToCompany(Company company) async {
    await initSounds();
    company.changes
        .where((event) => actionMapping[event] != null)
        .listen((event) {
        playSound(event);
    });
  }
}
