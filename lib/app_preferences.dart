import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._internal();

  static final AppPreferences instance = AppPreferences._internal();
  late SharedPreferences _preferences;
  String _languageCode = 'languageCode';
  String _gameSaveKey = 'gameSaveKey';
  String _isSoundEnabled = "isSoundEnabled";

  Future<SharedPreferences> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  bool getIsSoundEnabled() {
    return _preferences.getBool(_isSoundEnabled) ?? true;
  }

  Future setIsSoundEnabled(bool value) {
    return _preferences.setBool(_isSoundEnabled, value);
  }

  String? getUILanguage() {
    return _preferences.getString(_languageCode);
  }

  Future setUILanguage(String languageCode) async {
    return await _preferences.setString(_languageCode, languageCode);
  }

  Map<String, dynamic>? readGameSave() {
    try {
      var s = _preferences.getString(_gameSaveKey);
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
      return await _preferences.setString(_gameSaveKey, string);
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeSavedGame() async {
    return await _preferences.remove(_gameSaveKey);
  }
}
