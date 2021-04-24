import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const APP_VERSION = "1.0.6";

class ChumakiLocalizations {
  ChumakiLocalizations(this.locale);

  static ChumakiLocalizations of(BuildContext context) {
    return Localizations.of<ChumakiLocalizations>(
        context, ChumakiLocalizations)!;
  }

  static List supportedLanguageCodes = ["uk", "en", "ru"];
  final Locale locale;

  static Map<String, Map<String, String>> _localizedValues = {
    "en": {
      "stone": "Stone",
      "labelTitle": "Loca Deserta: Chumaki",
      "grains": "Grains",
      "cannon": "Cannon",
      "cart": "Cart",
      "charcoal": "Charcoal",
      "firearm": "Firearm",
      "fish": "Fish",
      "food": "Food",
      "fur": "Fur",
      "horse": "Horse",
      "ore": "Ore",
      "metalParts": "Metal Parts",
      "money": "Money",
      "planks": "Planks",
      "powder": "Powder",
      "wall": "Wall",
      "wood": "Wood",
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
      "food": "Food",
      "resources": "Resources",
      "cloths": "Cloths",
      "military": "Military",
      "luxury": "Luxury",
      "labelSell": "Sell",
      "labelBuy": "Buy",
    },
    "uk": {
      "stone": "Камінь",
      "labelTitle": "Дике Поле: Чумаки",
      "grains": "Зерно",
      "cannon": 'Гармата',
      "cart": "Віз",
      "charcoal": "Вугілля",
      "firearm": "Рушниця",
      "fish": "Риба",
      "food": "Їжа",
      "fur": "Хутра",
      "horse": "Кінь",
      "ore": "Руда",
      "metalParts": "Металеві шмати",
      "money": "Гроші",
      "planks": "Дошки",
      "powder": "Порох",
      "tower": "Башта",
      "wall": "Стіна",
      "wood": "Дерево",
      "labelPoints": "Бали",
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
      "food": "Їжа",
      "resources": "Ресурси",
      "cloths": "Одяг",
      "military": "Військове",
      "luxury": "Розкіш",
      "labelSell": "Продати",
      "labelBuy": "Купити",
    },
    "ru": {
      "stone": "Камень",
      "labelTitle": "Дикое Поле: Чумаки",
      "grains": "Зерно",
      "boat": "Лодка",
      "cannon": 'Пушка',
      "cart": "Воз",
      "charcoal": "Уголь",
      "firearm": "Самопал",
      "fish": "Рыба",
      "food": "Еда",
      "fur": "Меха",
      "horse": "Конь",
      "ore": "Руда",
      "metalParts": "Метал",
      "money": "Деньги",
      "planks": "Доски",
      "powder": "Порох",
      "wall": "Стена",
      "wood": "Дерево",
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
      "food": "Еда",
      "resources": "Ресурсы",
      "cloths": "Одежда",
      "military": "Военное",
      "luxury": "Розкош",
      "labelSell": "Продажа",
      "labelBuy": "Покупка",
    },
  };

  String getForKey(String key) {
    var value = _localizedValues[locale.languageCode]![key];
    if (value == null) {
      return key;
    } else {
      return value;
    }
  }

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

  String get tooltipSounds {
    return _localizedValues[locale.languageCode]!["tooltipSounds"]!;
  }

  String get tooltipNewGame {
    return _localizedValues[locale.languageCode]!["tooltipNewGame"]!;
  }

  String get tooltipShuffle {
    return _localizedValues[locale.languageCode]!["tooltipShuffle"]!;
  }

  String get labelOtherGames {
    return _localizedValues[locale.languageCode]!["labelOtherGames"]!;
  }

  String get nizhin {
    return _localizedValues[locale.languageCode]!["labelNizhin"]!;
  }

  String get sich {
    return _localizedValues[locale.languageCode]!["labelSich"]!;
  }

  String get chigirin {
    return _localizedValues[locale.languageCode]!["labelChigirin"]!;
  }

  String operator [](String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }

  String get labelSell {
    return _localizedValues[locale.languageCode]!["labelSell"]!;
  }
  String get labelBuy {
    return _localizedValues[locale.languageCode]!["labelBuy"]!;
  }
}

class HexLocalizationsDelegate
    extends LocalizationsDelegate<ChumakiLocalizations> {
  const HexLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ChumakiLocalizations.supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<ChumakiLocalizations> load(Locale locale) {
    return SynchronousFuture<ChumakiLocalizations>(
        ChumakiLocalizations(locale));
  }

  @override
  bool shouldReload(HexLocalizationsDelegate old) => false;
}
