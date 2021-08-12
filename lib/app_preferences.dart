import 'dart:convert';

import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum APP_PREFERENCES_EVENTS { SOUND_CHANGE }

class AppPreferences {
  AppPreferences._internal() {
    changes = _innerChanges.stream;
  }

  static final AppPreferences instance = AppPreferences._internal();
  SharedPreferences? _preferences;
  String _languageCode = 'languageCode';
  String _gameSaveKey = 'gameSaveKey';
  String _isSoundEnabled = "isSoundEnabled";

  final BehaviorSubject<APP_PREFERENCES_EVENTS> _innerChanges =
      BehaviorSubject();
  late final ValueStream<APP_PREFERENCES_EVENTS> changes;

  Future<SharedPreferences> init() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();

    }
    return _preferences!;
  }

  bool getIsSoundEnabled() {
    return _preferences!.getBool(_isSoundEnabled) ?? true;
  }

  Future setIsSoundEnabled(bool value) async {
    final result = await _preferences!.setBool(_isSoundEnabled, value);
    _innerChanges.add(APP_PREFERENCES_EVENTS.SOUND_CHANGE);
    return result;
  }

  Future toogleIsSoundEnabled() {
    final current = this.getIsSoundEnabled();
    return setIsSoundEnabled(!current);
  }

  String? getUILanguage() {
    return _preferences!.getString(_languageCode);
  }

  Future setUILanguage(String languageCode) async {
    return await _preferences!.setString(_languageCode, languageCode);
  }

  Map<String, dynamic>? readGameSave() {
    try {
      var s = _preferences!.getString(_gameSaveKey);
      if (s != null) {
        return jsonDecode(s);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future saveGameToDisk(Map<String, dynamic> json) async {
    var string = jsonEncode(json);
    try {
      return await _preferences!.setString(_gameSaveKey, string);
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeSavedGame() async {
    return await _preferences!.remove(_gameSaveKey);
  }
}
