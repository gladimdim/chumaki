import 'package:chumaki/i18n/resource_localizations.dart';
import 'package:flutter/material.dart';

const APP_VERSION = "1.0.6";

String getDefaultOrUrlLanguage() {
  var savedLangCode = "uk";
  // try {
  //   savedLangCode = AppPreferences.instance.getUILanguage();
  // } catch (e) {
  //   savedLangCode = 'uk';
  // }
  if (ChumakiLocalizations.supportedLanguageCodes.contains(savedLangCode)) {
    return savedLangCode;
  } else {
    return 'uk';
  }
}

class InternalLocalizations {
  Map<String, Map<String, String>> localizedMap = {};

  String operator [](String key) {
    final lang = localizedMap[ChumakiLocalizations.locale.languageCode]!;
    var value = lang[key];
    if (value != null) {
      return value;
    } else {
      return key;
    }
  }
}

class ChumakiLocalizations {
  static List supportedLanguageCodes = ["uk", "en", "ru"];

  static Locale locale = Locale(getDefaultOrUrlLanguage());

  static ResourceLocalizations resourceLocalizations = ResourceLocalizations();

  static String getForKey(String key) {
    final split = key.split('.');
    if (split.length > 1) {
      switch (split[0]) {
        case 'resources':
          return resourceLocalizations[split[1]];
        default:
          return key;
      }
    } else {
      final translatedValue = _localizedValues[locale.languageCode]![split[0]];
      return translatedValue != null ? translatedValue : split[0];
    }
  }

  static Map<String, Map<String, String>> _localizedValues = {
    "en": {
      "labelTitle": "Loca Deserta: Chumaki",
      "labelAbout": "About Game",
      "labelBack": "Back",
      "labelToMainMenu": "Main Menu",
      "labelSloboda": "Sloboda",
      "labelLocaDeserta": "Loca Deserta",
      "labelOtherGames": "My other games",
      "labelPickGameType": "Pick game type",
      "tooltipSettings": "Help",
      "tooltipSounds": "Sound",
      "tooltipNewGame": "New Game",
      "sich": "Sich",
      "nizhin": "Nizhin",
      "kaniv": "Kaniv",
      "kyiv": "Kyiv",
      "pereyaslav": "Pereyaslav",
      "cherkasy": "Cherkasy",
      "chigirin": "Chigirin",
      "labelSell": "Sell",
      "labelBuy": "Buy",
      "labelContains": "Contains",
      "labelNothing": "Nothing",
      "labelMarket": "Market",
      "labelPub": "Pub",
      "labelNewGame": "New Game",
      "labelNoSave": "No saved games",
      "labelLoadSave": "Load Saved Game",
    },
    "uk": {
      "labelTitle": "Дике Поле: Чумаки",
      "labelAbout": "Про гру",
      "labelBack": "Назад",
      "labelToMainMenu": "Головне Меню",
      "labelSloboda": "Слобода",
      "labelLocaDeserta": "Дике Поле",
      "labelOtherGames": "Мої інші ігри",
      "labelPickGameType": "Виберіть тип гри",
      "tooltipSettings": "Про гру",
      "tooltipSounds": "Звук",
      "tooltipNewGame": "Нова Гра",
      "sich": "Січ",
      "nizhin": "Ніжин",
      "kaniv": "Канів",
      "kyiv": "Київ",
      "pereyaslav": "Переяслав",
      "cherkasy": "Черкаси",
      "chigirin": "Чигирин",
      "labelSell": "Продати",
      "labelBuy": "Купити",
      "labelContains": "Містить",
      "labelNothing": "Нічого",
      "labelMarket": "Ринок",
      "labelPub": "Шинок",
      "labelNewGame": "Нова Гра",

      "labelNoSave": "Немає збережених ігор",
      "labelLoadSave": "Завантажити",
    },
    "ru": {
      "labelTitle": "Дикое Поле: Чумаки",
      "labelAbout": "Про игру",
      "labelBack": "Назад",
      "labelToMainMenu": "Главное Меню",
      "labelSloboda": "Слобода",
      "labelLocaDeserta": "Дикое Поле",
      "labelOtherGames": "Мои другие игры",
      "tooltipSettings": "Про игру",
      "tooltipSounds": "Звук",
      "tooltipNewGame": "Новая Игра",
      "sich": "Сичь",
      "nizhin": "Нежин",
      "kaniv": "Канев",
      "kyiv": "Киев",
      "pereyaslav": "Переяслав",
      "cherkasy": "Черкассы",
      "chigirin": "Чигирин",
      "labelSell": "Продажа",
      "labelBuy": "Покупка",
      "labelContains": "Имеет",
      "labelNothing": "Ничего",
      "labelMarket": "Рынок",
      "labelPub": "Шинок",
      "labelNewGame": "Новая игра",

      "labelNoSave": "Нету сохраненых игр",
      "labelLoadSave": "Загрузить",

    },
  };

  String get labelTitle {
    return _localizedValues[locale.languageCode]!["labelTitle"]!;
  }

  String get labelPoints {
    return _localizedValues[locale.languageCode]!["labelPoints"]!;
  }

  String get labelGameOver {
    return _localizedValues[locale.languageCode]!["labelGameOver"]!;
  }

  String get labelCapture {
    return _localizedValues[locale.languageCode]!["labelCapture"]!;
  }

  String get labelAbout {
    return _localizedValues[locale.languageCode]!["labelAbout"]!;
  }

  String get labelBack {
    return _localizedValues[locale.languageCode]!["labelBack"]!;
  }

  String get labelToMaiMenu {
    return _localizedValues[locale.languageCode]!["labelToMainMenu"]!;
  }

  String get labelPickGameType {
    return _localizedValues[locale.languageCode]!["labelPickGameType"]!;
  }

  String get textHowToPlay {
    return _localizedValues[locale.languageCode]!["textHowToPlay"]!;
  }

  String get tooltipSettings {
    return _localizedValues[locale.languageCode]!["tooltipSettings"]!;
  }

  static String get tooltipSounds {
    return _localizedValues[locale.languageCode]!["tooltipSounds"]!;
  }

  static String get tooltipNewGame {
    return _localizedValues[locale.languageCode]!["tooltipNewGame"]!;
  }

  static String get tooltipShuffle {
    return _localizedValues[locale.languageCode]!["tooltipShuffle"]!;
  }

  static String get labelOtherGames {
    return _localizedValues[locale.languageCode]!["labelOtherGames"]!;
  }

  static String get labelContains {
    return _localizedValues[locale.languageCode]!["labelContains"]!;
  }

  static String get labelNothing {
    return _localizedValues[locale.languageCode]!["labelNothing"]!;
  }

  static String get labelMarket {
    return _localizedValues[locale.languageCode]!["labelMarket"]!;
  }

  static String get labelPub {
    return _localizedValues[locale.languageCode]!["labelPub"]!;
  }

  static String get nizhin {
    return _localizedValues[locale.languageCode]!["labelNizhin"]!;
  }

  static String get sich {
    return _localizedValues[locale.languageCode]!["labelSich"]!;
  }

  static String get chigirin {
    return _localizedValues[locale.languageCode]!["labelChigirin"]!;
  }

  String operator [](String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }

  static String get labelSell {
    return _localizedValues[locale.languageCode]!["labelSell"]!;
  }

  static String get labelBuy {
    return _localizedValues[locale.languageCode]!["labelBuy"]!;
  }

  static String get labelNewGame {
    return _localizedValues[locale.languageCode]!["labelNewGame"]!;
  }

  static String get labelNoSave {
    return _localizedValues[locale.languageCode]!["labelNoSave"]!;
  }


  static String get labelLoadSave {
    return _localizedValues[locale.languageCode]!["labelLoadSave"]!;
  }
}
