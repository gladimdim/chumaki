import 'package:chumaki/i18n/achievements_localizations.dart';
import 'package:chumaki/i18n/event_localizations.dart';
import 'package:chumaki/i18n/leaders_localizations.dart';
import 'package:chumaki/i18n/manufacturing_localizations.dart';
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
  static LeadersLocalizations leadersLocalizations = LeadersLocalizations();
  static EventLocalizations eventLocalizations = EventLocalizations();
  static ManufacturingLocalizations manufacutringLocalizations =
      ManufacturingLocalizations();
  static AchievementsLocalizations achievementsLocalizations =
      AchievementsLocalizations();

  static String getForKey(String key) {
    final split = key.split('.');
    if (split.length > 1) {
      switch (split[0]) {
        case 'resources':
          return resourceLocalizations[split[1]];

        case 'leaders':
          return leadersLocalizations[split[1]];
        case "events":
          return eventLocalizations[split[1]];
        case "manufacturings":
          return manufacutringLocalizations[split[1]];
        case "achievements":
          return achievementsLocalizations[split[1]];
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
      "labelLocaDesertaSloboda": "Sloboda",
      "labelLocaDeserta": "Loca Deserta",
      "labelLocaDesertaHex": "Hex",
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
      "ochakiv": "Ochakiv",
      "chernigiv": "Chernihiv",
      "lviv": "Lviv",
      "ostrog": "Ostrog",
      "zhytomir": "Zhytomir",
      "temryuk": "Temryuk",
      "bilatserkva": "Bila Tserkva",
      "vinnitsa": "Vinnitsa",
      "berdychiv": "Berdychiv",
      "uman": "Uman",
      "korsun": "Korsun",
      "stavise": "Stavise",
      "ladyzhin": "Ladyzhin",
      "gaivoron": "Gaivoron",
      "pyryatin": "Pyryatin",
      "myrgorod": "Myrgorod",
      "govtva": "Govtva",
      "kursk": "Kursk",
      "rylsk": "Rylsk",
      "ternopil": "Ternopil",
      "medzhibizh": "Medzhibizh",
      "labelSell": "Sell",
      "labelBuy": "Buy",
      "labelContains": "Contains",
      "labelNothing": "Nothing",
      "labelMarket": "Market",
      "labelPub": "Pub",
      "labelNewGame": "New Game",
      "labelNoSave": "No saved games",
      "labelLoadSave": "Load Saved Game",
      "labelWorldMarket": "World Market",
      "labelCompany": "Company",
      "labelSend": "Send",
      "labelCompanyContains": "Company has",
      "labelTotalPrice": "Total price of",
      "labelUnlockCity": "Buy access to town",
      "labelBuyNewWagon": "Buy new wagon",
      "labelCompanies": "Companies",
      "labelMenuBuyNewRoutes": "Unlock Routes",
      "textAllRoutesBought":
          "All possible routes known in this town are already bought",
      "labelWagonPricesInCities": "Prices for all wagons in different cities",
      "labelGlobalPrices": "Global Prices",
      "labelHire": "Hire",
      "labelLeader": "Leader",
      "labelLevel": "Level",
      "labelExperience": "Experience",
      "labelAvailablePerks": "Available Perks",
      "labelListOfPerks": "Perks",
      "labelUnlockAt": "Buy route at",
      "labelCityIsLocked": "City is locked",
      "labelGoTo": "Go to",
      "labelPrice": "Price",
      "labelProfit": "Profit",
      "labelProductionCenter": "Production center of",
      "labelRequirements": "Delivering request",
      "labelPayment": "Payment",
      "labelGive": "Give",
      "labelTakePayment": "Receive",
      "labelTrade": "Trade",
      "labelOtherCities": "Other cities",
      "labelLeveledUp": "New level",
      "labelBuild": "Build",
      "labelUpgrade": "Ugrade",
      "labelManufacturing": "Manufacturing",
      "labelLoggerBoughtStats": "You bought this much",
      "labelLoggerSoldStats": "You sold this much",
      "labelGameStats": "Game Stats View",
      "labelRecall": "Recall",
      "labelAchievements": "Achievements",
      "labelRequiredToSell": "Required to sell",
      "labelRequiredToBuy": "Required to buy",
      "labelRequired": "Required",
      "labelLeadersHired": "Leaders hired",
      "labelWagonsBought": "Wagons bought",
      "labelCompletedCityEvents": "Events completed",
      "labelRequiredToDoCityEvents": "City events to finish",
    },
    "uk": {
      "labelTitle": "Дике Поле: Чумаки",
      "labelAbout": "Про гру",
      "labelBack": "Назад",
      "labelToMainMenu": "Головне Меню",
      "labelLocaDesertaSloboda": "Слобода",
      "labelLocaDeserta": "Дике Поле",
      "labelLocaDesertaHex": "Гекс",
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
      "ochakiv": "Очаків",
      "chernigiv": "Чернігів",
      "lviv": "Львів",
      "ostrog": "Острог",
      "zhytomir": "Житомир",
      "temryuk": "Темрюк",
      "bilatserkva": "Біла Церква",
      "vinnitsa": "Вінниця",
      "berdychiv": "Бердичів",
      "uman": "Умань",
      "korsun": "Корсунь",
      "stavise": "Ставище",
      "ladyzhin": "Ладижин",
      "gaivoron": "Гайворон",
      "pyryatin": "Пирятин",
      "myrgorod": "Миргород",
      "govtva": "Говтва",
      "kursk": "Курськ",
      "rylsk": "Рильськ",
      "ternopil": "Тернопіль",
      "medzhibizh": "Меджибіж",
      "labelSell": "Продати",
      "labelBuy": "Купити",
      "labelContains": "Містить",
      "labelNothing": "Нічого",
      "labelMarket": "Ринок",
      "labelPub": "Шинок",
      "labelNewGame": "Нова Гра",
      "labelNoSave": "Немає збережених ігор",
      "labelLoadSave": "Завантажити",
      "labelWorldMarket": "Світовий ринок",
      "labelCompany": "Ватага",
      "labelSend": "Відправити",
      "labelCompanyContains": "Валка має",
      "labelTotalPrice": "Загальна вартість",
      "labelUnlockCity": "Купити доступ до міста",
      "labelBuyNewWagon": "Купити нову валку",
      "labelCompanies": "Ватаги",
      "labelMenuBuyNewRoutes": "Купити маршрути",
      "textAllRoutesBought":
          "Всі можливі маршрути, які знають в цьому місті, уже куплено.",
      "labelWagonPricesInCities": "Ціни за всі валки в різних містах",
      "labelGlobalPrices": "Світові ціни",
      "labelHire": "Найняти",
      "labelLeader": "Отаман",
      "labelLevel": "Рівень",
      "labelExperience": "Досвід",
      "labelAvailablePerks": "Доступно перків",
      "labelListOfPerks": "Перки",
      "labelUnlockAt": "Купити маршрут в",
      "labelCityIsLocked": "Доступ до міста закритий",
      "labelGoTo": "Перейти",
      "labelPrice": "Ціна",
      "labelProfit": "Прибуток",
      "labelProductionCenter": "Центр виробництва",
      "labelRequirements": "Необхідно доставити",
      "labelPayment": "Винагорода",
      "labelGive": "Віддати",
      "labelTakePayment": "Отримати",
      "labelTrade": "Торгівля",
      "labelOtherCities": "Інші міста",
      "labelLeveledUp": "Новий рівень",
      "labelBuild": "Побудувати",
      "labelUpgrade": "Оновити",
      "labelManufacturing": "Виробництво",
      "labelLoggerBoughtStats": "Ви купили ось стільки",
      "labelLoggerSoldStats": "Ви продали ось стільки",
      "labelGameStats": "Статистика всієї гри",
      "labelRecall": "Викликати",
      "labelAchievements": "Досягнення",
      "labelRequiredToSell": "Необхідно продати",
      "labelRequiredToBuy": "Необхідно купити",
      "labelRequired": "Необхідно",
      "labelLeadersHired": "Найнято отаманів",
      "labelWagonsBought": "Куплено возів",
      "labelCompletedCityEvents": "Завершено подій",
      "labelRequiredToDoCityEvents": "Виконати завдань",
    },
    "ru": {
      "labelTitle": "Дикое Поле: Чумаки",
      "labelAbout": "Про игру",
      "labelBack": "Назад",
      "labelToMainMenu": "Главное Меню",
      "labelLocaDesertaSloboda": "Слобода",
      "labelLocaDeserta": "Дикое Поле",
      "labelOtherGames": "Мои другие игры",
      "labelLocaDesertaHex": "Гекс",
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
      "ochakiv": "Очаков",
      "chernigiv": "Чернигов",
      "lviv": "Львов",
      "ostrog": "Острог",
      "zhytomir": "Житомир",
      "temryuk": "Темрюк",
      "bilatserkva": "Белая Церковь",
      "vinnitsa": "Винница",
      "berdychiv": "Бердычев",
      "uman": "Умань",
      "korsun": "Корсунь",
      "stavise": "Ставище",
      "ladyzhin": "Ладыжин",
      "gaivoron": "Гайворон",
      "pyryatin": "Пирятин",
      "myrgorod": "Миргород",
      "govtva": "Говтва",
      "kursk": "Курск",
      "rylsk": "Рильск",
      "ternopil": "Тернополь",
      "medzhibizh": "Меджибож",
      "labelSell": "Продажа",
      "labelBuy": "Покупка",
      "labelContains": "Имеет",
      "labelNothing": "Ничего",
      "labelMarket": "Рынок",
      "labelPub": "Шинок",
      "labelNewGame": "Новая игра",
      "labelNoSave": "Нету сохраненых игр",
      "labelLoadSave": "Загрузить",
      "labelWorldMarket": "Мировой рынок",
      "labelCompany": "Ватага",
      "labelSend": "Отправить",
      "labelCompanyContains": "Ватага имеет",
      "labelTotalPrice": "Полная стоимость",
      "labelUnlockCity": "Купить доступ к городу",
      "labelBuyNewWagon": "Купить новую валку",
      "labelCompanies": "Ватаги",
      "labelMenuBuyNewRoutes": "Купить маршруты",
      "textAllRoutesBought":
          "Все возможные маршруты, которые знают в этом городе уже куплены",
      "labelWagonPricesInCities": "Цены за все валки в разных городах",
      "labelGlobalPrices": "Глобальные цены",
      "labelHire": "Нанять",
      "labelLeader": "Атаман",
      "labelLevel": "Уровень",
      "labelExperience": "Опыт",
      "labelAvailablePerks": "Доступных перков",
      "labelListOfPerks": "Перки",
      "labelUnlockAt": "Купить маршрут в",
      "labelCityIsLocked": "Доступ в город закрыт",
      "labelGoTo": "Перейти",
      "labelPrice": "Цена",
      "labelProfit": "Выгода",
      "labelProductionCenter": "Центр производства",
      "labelRequirements": "Необходимо доставить",
      "labelPayment": "Вознаграждение",
      "labelGive": "Отдать",
      "labelTakePayment": "Получить",
      "labelTrade": "Торговать",
      "labelOtherCities": "Другие города",
      "labelLeveledUp": "Новый уровень",
      "labelBuild": "Построить",
      "labelUpgrade": "Обновить",
      "labelManufacturing": "Производство",
      "labelLoggerBoughtStats": "Вы купили вот столько",
      "labelLoggerSoldStats": "Вы продали вот столько",
      "labelGameStats": "Статистика всей игры",
      "labelRecall": "Вызвать",
      "labelAchievements": "Достижения",
      "labelRequiredToSell": "Необходимо продать",
      "labelRequiredToBuy": "Необходимо купить",
      "labelRequired": "Необходимо",
      "labelLeadersHired": "Нанято отаманов",
      "labelWagonsBought": "Куплено возов",
      "labelCompletedCityEvents": "Завершено заданий",
      "labelRequiredToDoCityEvents": "Выполнить заданий",

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

  static String get labelWorldMarket {
    return _localizedValues[locale.languageCode]!["labelWorldMarket"]!;
  }

  static String get labelCompany {
    return _localizedValues[locale.languageCode]!["labelCompany"]!;
  }

  static String get labelSend {
    return _localizedValues[locale.languageCode]!["labelSend"]!;
  }

  static String get labelCompanyContains {
    return _localizedValues[locale.languageCode]!["labelCompanyContains"]!;
  }

  static String get labelTotalPrice {
    return _localizedValues[locale.languageCode]!["labelTotalPrice"]!;
  }

  static String get labelUnlockCity {
    return _localizedValues[locale.languageCode]!["labelUnlockCity"]!;
  }

  static String get labelBuyNewWagon {
    return _localizedValues[locale.languageCode]!["labelBuyNewWagon"]!;
  }

  static String get labelCompanies {
    return _localizedValues[locale.languageCode]!["labelCompanies"]!;
  }

  static String get labelMenuBuyNewRoutes {
    return _localizedValues[locale.languageCode]!["labelMenuBuyNewRoutes"]!;
  }

  static String get textAllRoutesBought {
    return _localizedValues[locale.languageCode]!["textAllRoutesBought"]!;
  }

  static String get labelWagonPricesInCities {
    return _localizedValues[locale.languageCode]!["labelWagonPricesInCities"]!;
  }

  static String get labelGlobalPrices {
    return _localizedValues[locale.languageCode]!["labelGlobalPrices"]!;
  }

  static String get labelLeader {
    return _localizedValues[locale.languageCode]!["labelLeader"]!;
  }

  static String get labelHire {
    return _localizedValues[locale.languageCode]!["labelHire"]!;
  }

  static String get labelExperience {
    return _localizedValues[locale.languageCode]!["labelExperience"]!;
  }

  static String get labelLevel {
    return _localizedValues[locale.languageCode]!["labelLevel"]!;
  }

  static String get labelAvailablePerks {
    return _localizedValues[locale.languageCode]!["labelAvailablePerks"]!;
  }

  static String get labelListOfPerks {
    return _localizedValues[locale.languageCode]!["labelListOfPerks"]!;
  }

  static String get labelUnlockAt {
    return _localizedValues[locale.languageCode]!["labelUnlockAt"]!;
  }

  static String get labelCityIsLocked {
    return _localizedValues[locale.languageCode]!["labelCityIsLocked"]!;
  }

  static String get labelGoTo {
    return _localizedValues[locale.languageCode]!["labelGoTo"]!;
  }

  static String get labelProfit {
    return _localizedValues[locale.languageCode]!["labelProfit"]!;
  }

  static String get labelPrice {
    return _localizedValues[locale.languageCode]!["labelPrice"]!;
  }

  static String get labelProductionCenter {
    return _localizedValues[locale.languageCode]!["labelProductionCenter"]!;
  }

  static String get labelRequirements {
    return _localizedValues[locale.languageCode]!["labelRequirements"]!;
  }

  static String get labelPayment {
    return _localizedValues[locale.languageCode]!["labelPayment"]!;
  }

  static String get labelGive {
    return _localizedValues[locale.languageCode]!["labelGive"]!;
  }

  static String get labelTakePayment {
    return _localizedValues[locale.languageCode]!["labelTakePayment"]!;
  }

  static String get labelTrade {
    return _localizedValues[locale.languageCode]!["labelTrade"]!;
  }

  static String get labelOtherCities {
    return _localizedValues[locale.languageCode]!["labelOtherCities"]!;
  }

  static String get labelLeveledUp {
    return _localizedValues[locale.languageCode]!["labelLeveledUp"]!;
  }

  static String get labelBuild {
    return _localizedValues[locale.languageCode]!["labelBuild"]!;
  }

  static String get labelUpgrade {
    return _localizedValues[locale.languageCode]!["labelUpgrade"]!;
  }

  static String get labelManufacturing {
    return _localizedValues[locale.languageCode]!["labelManufacturing"]!;
  }

  static String get labelLoggerBoughtStats {
    return _localizedValues[locale.languageCode]!["labelLoggerBoughtStats"]!;
  }

  static String get labelLoggerSoldStats {
    return _localizedValues[locale.languageCode]!["labelLoggerSoldStats"]!;
  }

  static String get labelGameStats {
    return _localizedValues[locale.languageCode]!["labelGameStats"]!;
  }

  static String get labelRecall {
    return _localizedValues[locale.languageCode]!["labelRecall"]!;
  }

  static String get labelAchievements {
    return _localizedValues[locale.languageCode]!["labelAchievements"]!;
  }

  static String get labelRequiredToBuy {
    return _localizedValues[locale.languageCode]!["labelRequiredToBuy"]!;
  }

  static String get labelRequiredToSell {
    return _localizedValues[locale.languageCode]!["labelRequiredToSell"]!;
  }

  static String get labelRequired {
    return _localizedValues[locale.languageCode]!["labelRequired"]!;
  }

  static String get labelWagonsBought {
    return _localizedValues[locale.languageCode]!["labelWagonsBought"]!;
  }

  static String get labelLeadersHired {
    return _localizedValues[locale.languageCode]!["labelLeadersHired"]!;
  }

  static String get labelCompletedCityEvents {
    return _localizedValues[locale.languageCode]!["labelCompletedCityEvents"]!;
  }

  static String get labelRequiredToDoCityEvents {
    return _localizedValues[locale.languageCode]![
        "labelRequiredToDoCityEvents"]!;
  }
}
