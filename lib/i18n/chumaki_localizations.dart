import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/i18n/achievements_localizations.dart';
import 'package:chumaki/i18n/event_localizations.dart';
import 'package:chumaki/i18n/leaders_localizations.dart';
import 'package:chumaki/i18n/manufacturing_localizations.dart';
import 'package:chumaki/i18n/notification_localizations.dart';
import 'package:chumaki/i18n/resource_localizations.dart';
import 'package:flutter/material.dart';

const APP_VERSION = "1.0.0";

String getDefaultOrUrlLanguage() {
  String? savedLangCode = "uk";
  try {
    savedLangCode = AppPreferences.instance.getUILanguage();
  } catch (e) {
    savedLangCode = 'uk';
  }
  if (savedLangCode == null) {
    savedLangCode = "uk";
  }
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
  static NotificationLocalizations notificationLocalizations =
      NotificationLocalizations();
  static ManufacturingLocalizations manufacturingLocalizations =
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
          return manufacturingLocalizations[split[1]];
        case "achievements":
          return achievementsLocalizations[split[1]];
        case "notifications":
          return notificationLocalizations[split[1]];
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
      "ohtirka": "Ohtirka",
      "labelSell": "Sell",
      "labelBuy": "Buy",
      "labelSell2": "Selling",
      "labelBuy2": "Buying",
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
      "labelLeadersHired": "Leaders",
      "labelWagonsBought": "Wagons",
      "labelCompletedCityEvents": "Events",
      "labelRequiredToDoCityEvents": "City events to finish",
      "labelWagonContains": "Wagon contains",
      "labelSound": "Sound",
      "labelHelp": "Help",
      "labelMyAchievementProgress": "My achievement progress",
      "labelShortGameDescription":
      "Download game Chumaki at https://locadeserta.com/locadesertachumaki/index_en",
      "labelHelpOverviewTitle": "Gameplay",
      "labelHelpTitleOverview1": "TLDR 👉",
      "labelHelpTextOverview1": """Buy low. Sell high. Do the tasks.""",
      "labelHelpTitleOverview2": "Game full description 😎 👇",
      "labelHelpTextOverview2": """

You start as a tarder with a single wagon. The first is to identify valuable roots between cities, what city trades what and so on.
All goods have manufacturing centers, where the price is the lowest. So, to make some money, you have to buy at manufacturing center
and sell it in some far city for higher price.
To optimize the travels, find such a route that benefits you in both directions.
Hire a leader for the wagon then you can get experience and unlock new goods categories.
When you enter a town, an event can be generated for you. Doing it gives you LOTS of money.
Look at the Achievements list to make game more fun. :)

Hint 😻: unlock Kyiv, Chernigiv and Ochakiv first. Trade salt <-> woods/planks/coal between them for max profit 😉
""",
      "labelHelpTitleOtamans": "Leaders 🤠",
      "labelHelpTextOtamans": """

You can hire leader for the wagon. This gives you possibility to earn experience. Each time when you sell your leader will get exp.
After getting new level one perk is available and you can use it to pick category to unlock.
""",
      "labelHelpTitleTowns": "Towns 🏙",
      "labelHelpTextTowns": """

Lots of towns are blocked at the beginning. You need to pay money to buy routes.
Some towns are manufacturing centers, that is why the prices for such goods are lower and more plent on the market.""",
      "labelHelpTitleEvents": "Events 🎆",
      "labelHelpTextEvents": """

When wagon visits the town an event get be generated for you. If completed you get LOTS of money. And the possibility to get another one :)
""",
      "labelHelpTitleWagons": "Wagons 🛺",
      "labelHelpTextWagons": """

You can buy a new wagon in any city. All wagons are independent but share the bank.
Wagon has a limit - 100 kg.
Each wagon can hire a leader and level him up to unlock more goods for trade.""",
      "labelHelpTitleManufacturing": "Manufacturings 🏭",
      "labelHelpTextManufacturing": """
 
 You need to build manufacturings in order to regenerate goods on the market.
 They are replenished each time you visit a town.
 To get even more resources - level up manufacturings to 2-3 levels.""",
      "labelHelpTitleAchievements": "Achievements 🦸",
      "labelHelpTextAchievements": """

The game has more than 20 achievements. There is no war so all of them are about trading.""",
      "labelHelpTitleMarket": "Trading/Market 🛃",
      "labelHelpTextMarket": """

When the wagon stops in town it can start a trade.
For this open the Wagon menu, go to Trade section and start moving the goods.
To check the prices and the benefits - open World Market menu.
""",
      "labelHelpTitleGlobalMarket": "World Market 🗺️",
      "labelHelpTextGlobalMarket": """

Here you can check the prices in different towns and the margins you may earn.
But be careful - you can go below zero! The rule is simple - manufacturing centers have the lowest price. The farther from it the highter the price.
""",
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
      "ohtirka": "Охтирка",
      "labelSell": "Продати",
      "labelBuy": "Купити",
      "labelSell2": "Продаж",
      "labelBuy2": "Купівля",
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
      "labelLeadersHired": "Отаманів",
      "labelWagonsBought": "Возів",
      "labelCompletedCityEvents": "Подій",
      "labelRequiredToDoCityEvents": "Виконати міських завдань",
      "labelWagonContains": "Вміст ватаги",
      "labelSound": "Звук",
      "labelHelp": "Допомога",
      "labelMyAchievementProgress": "Мій прогрес в досягнені",
      "labelShortGameDescription":
          "Скачай гру Чумаки: https://locadeserta.com/locadesertachumaki",
      "labelHelpOverviewTitle": "Ігролад",
      "labelHelpTitleOverview1": "Гра коротко 👉",
      "labelHelpTextOverview1":
          """Купуй дешево. Продавай дорого. Виконуй задачі.""",
      "labelHelpTitleOverview2": "Гра не коротко 😎 👇",
      "labelHelpTextOverview2": """

Ви починаєте як торговець з однією ватагою. Першою задачею є розвідати торгові маршрути між містами, подивиться чим торгують і чи буде маржа на цей товар.
Всі товари мають центри виробництв, де ціна на них найнижча. Тому, щоб продати подорожче, треба їхати в дальне місто.
Щоб оптимізувати подорожі, знайдіть такий маршрут, який буде вигідний у двох напрямках.
Найміть отамана для ватаги, тоді ви зможете його прокачувати і отримаєте доступ до нових категорій товарів.
При відвідуванні міст може з'явитися задача, за виконання якої отримаєте великі гроші.
Перегляньте список Досягнень, щоб було цікавіше грати :)


Порада 😻: Відкрийте Київ, Чернігів та Очаків. Торгуйте сіллю <-> деревом/дошками/вугіллям між ними. Це перший маршрут з максимальною вигодою 😉
""",
      "labelHelpTitleOtamans": "Отамани 🤠",
      "labelHelpTextOtamans": """

Ви можете винайняти отамана у ватагу. Це дає вам змогу прокачувати його. Кожен раз, коли ви щось продаєте, отаман ватаги отримує досвід.
Після досягнення нового рівня ви зможете відкрити нову категорію товару для торгівлі цією ватагою.""",
      "labelHelpTitleTowns": "Міста 🏙",
      "labelHelpTextTowns": """

Багато міст заблоковано на початку гри. Треба заплатити кошти, щоб їх відкрити для торгівлі.
Більшість міст є центром виробництва якогось ресурсу, тому там ціна найменша. А також на ринку цих ресурсів буде значно більше, ніж в інших містах.""",
      "labelHelpTitleEvents": "Події 🎆",
      "labelHelpTextEvents": """

При відвідуванні міста, може з'явитися задача. Виконавши її ви отримуєте ДУЖЕ значні кошти. А також можливість отримати ще одну задачку :)
""",
      "labelHelpTitleWagons": "Ватаги 🛺",
      "labelHelpTextWagons": """

Ви можете купити ще одну ватагу у будь-якому місті. Вона діє незалежно від інших ватаг, але кошти всі спільні.
Ватага має обмеження по перевезенню - 100 кг.
Кожній ватазі можна найняти отамана і окремо його прокачувати, щоб відкрити нові товари для торгівлі.""",
      "labelHelpTitleManufacturing": "Виробництва 🏭",
      "labelHelpTextManufacturing": """
 
 В містах можна будувати виробництва профільних товарів. Це дає змогу поповнювати запаси ресурсів на ринку.
 Ресурси регенеруються кожен раз, як ватага заходить у місто.
 Для збільшення обсягів прокачайте виробництво до 2-3 рівнів.""",
      "labelHelpTitleAchievements": "Досягнення 🦸",
      "labelHelpTextAchievements": """

В грі є більше 20 різноманітних досягнень. В грі немає війни, тому вони всі зав'язані на торгівлю або на виконання задач.""",
      "labelHelpTitleMarket": "Торгівля/Ринок 🛃",
      "labelHelpTextMarket": """

Коли ватага стає в місті, вона може торгувати на місцевому ринку.
Для цього відкрийте меню з ватагою, перейдіть на секцію Торгівля та почніть продавати або купувати товари.
Для того, щоб перевірити ціну на товар та маржу на них на всій мапі - відкрийте Світовий Ринок.
""",
      "labelHelpTitleGlobalMarket": "Світовий ринок 🗺️",
      "labelHelpTextGlobalMarket": """

Тут можна перевірити ціни на всі товари в різних місцях, а також вигоду, як отримаєте, якщо купите товар, а продасте в іншому місті.
Але будьте уважні - можна уйти в мінус! Правило просте - центр виробництва товару має найнижчу ціну. Чим далі від центру, тим дорожчає товар.
""",
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
      "ohtirka": "Ахтырка",
      "labelSell": "Продать",
      "labelBuy": "Купить",
      "labelSell2": "Продажа",
      "labelBuy2": "Покупка",
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
      "labelLeadersHired": "Атаманов",
      "labelWagonsBought": "Возов",
      "labelCompletedCityEvents": "Заданий",
      "labelRequiredToDoCityEvents": "Выполнить городских заданий",
      "labelWagonContains": "Состав ватаги",
      "labelSound": "Звук",
      "labelHelp": "Помощь",
      "labelMyAchievementProgress": "Мой прогресс в достижении",
      "labelShortGameDescription":
          "Скачай игру Чумаки: https://locadeserta.com/locadesertachumaki",
      "labelHelpOverviewTitle": "Игролад",
      "labelHelpTitleOverview1": "Игра коротко 👉",
      "labelHelpTextOverview1":
          """Покупай дешево. Продавай дорого. Выполняй задачи.""",
      "labelHelpTitleOverview2": "Игра не коротко 😎 👇",
      "labelHelpTextOverview2": """

Вы начинаете как торговец с одним возом. Первой задачей будет разведать маршруты между городами, посмотреть чем торгуют и какая будет маржа.
Все товары имеют центры производства, где цена на них самая минимальная. По этому, чтобы продать подороже, надо отьехать подальше :).
Чтобы оптимизировать путешествия, найдите такой маршрут, который будет выгодным в обе стороны.
Наймите атамана для ватаги, тогда сможете его прокачивать и получаете доступ к новым категориям товаров.
Когда вы заходите в город, то может появится новая задача за выполнения которой получаете ОЧЕНЬ хорошие деньги.
Просмотрите список достижений, чтобы было интересней играть :)

Подсказка 😻: Откройте Киев, Чернигов и Очаков. Торгуйте между ними солью <-> деревом/досками/углем. Это первый маршрут с максимальной выгодой 😉

""",
      "labelHelpTitleOtamans": "Атаманы 🤠",
      "labelHelpTextOtamans": """

Вы можете нанять атамана в ватагу. Это даст возможность его прокачать. Каждый раз, когда идет продажа, атаман получает опыт.
После достижения нового уровня, можна получить перк, который откроет новую категорию товаров.""",
      "labelHelpTitleTowns": "Города 🏙",
      "labelHelpTextTowns": """

Много городов заблокировано с начала игры. Надо платить деньги, чтобы купить к ним маршрут и открыть торговлю.
Большинство городов являются центрами производства, по этому цена там наименьшая, а также на рынке будет их побольше.""",
      "labelHelpTitleEvents": "Собыия 🎆",
      "labelHelpTextEvents": """

При визите ватаги в город может появится задача. Если ее выполнить, то получите ОЧЕНЬ хорошие деньги. А также возможность получить еще одну задачку :)
""",
      "labelHelpTitleWagons": "Ватаги 🛺",
      "labelHelpTextWagons": """

Можете купить еще одну ватагу в любом городе. Все ватаги независимы, но имеют общий банк денег.
Ватага имет ограничения по весу - 100 кг.
Каждая ватага может нанять атамана и отдельно его прокачивать, чтобы открыть новые категории товаров.""",
      "labelHelpTitleManufacturing": "Производства 🏭",
      "labelHelpTextManufacturing": """
 
 В городах надо строить производства профильных товаров. Это дает возможность пополнять запасы на рынке.
 Ресурсы генерируются каждый раз, как ватага заходит в город.
 Для увеличения запасов прокачайте производство до 2-3 уровней.""",
      "labelHelpTitleAchievements": "Достижения 🦸",
      "labelHelpTextAchievements": """

В игре есть больеш 20 разных достижений. В игре нету войны, по этому они все завязаны на торговлю или на выполнение задач.""",
      "labelHelpTitleMarket": "Торговля/Рынок 🛃",
      "labelHelpTextMarket": """

Когда ватага останавливается в городе, она может торговать с этим рынком.
Для этого откройте меню с ватагой, перейдите на секцию Торговля и начните продавать или покупать товары.
Для того, чтобы проверить цену на товар и маржу на них по всей карте - откроей Мировой Рынок.
""",
      "labelHelpTitleGlobalMarket": "Мировой рынок 🗺️",
      "labelHelpTextGlobalMarket": """

Тут можна проверить цены на все товары в разных городах, а также выгоду, которую получите, если продадите товар.
Но будьте внимательны - можна уйти в минус! Правило простое - центр производства товара имеет самую низкую цену. Чем дальше от него, тем дороже товар.
""",
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

  static String get labelSell2 {
    return _localizedValues[locale.languageCode]!["labelSell2"]!;
  }

  static String get labelBuy {
    return _localizedValues[locale.languageCode]!["labelBuy"]!;
  }

  static String get labelBuy2 {
    return _localizedValues[locale.languageCode]!["labelBuy2"]!;
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

  static String get labelWagonContains {
    return _localizedValues[locale.languageCode]!["labelWagonContains"]!;
  }

  static String get labelSound {
    return _localizedValues[locale.languageCode]!["labelSound"]!;
  }

  static String get labelHelp {
    return _localizedValues[locale.languageCode]!["labelHelp"]!;
  }

  static String get labelHelpOverviewTitle {
    return _localizedValues[locale.languageCode]!["labelHelpOverviewTitle"]!;
  }

  static String get labelHelpTextOverview1 {
    return _localizedValues[locale.languageCode]!["labelHelpTextOverview1"]!;
  }

  static String get labelHelpTitleOverview1 {
    return _localizedValues[locale.languageCode]!["labelHelpTitleOverview1"]!;
  }

  static String get labelHelpTextOverview2 {
    return _localizedValues[locale.languageCode]!["labelHelpTextOverview2"]!;
  }

  static String get labelHelpTitleOverview2 {
    return _localizedValues[locale.languageCode]!["labelHelpTitleOverview2"]!;
  }

  static String get labelHelpTextOtamans {
    return _localizedValues[locale.languageCode]!["labelHelpTextOtamans"]!;
  }

  static String get labelHelpTitleOtamans {
    return _localizedValues[locale.languageCode]!["labelHelpTitleOtamans"]!;
  }

  static String get labelHelpTextTowns {
    return _localizedValues[locale.languageCode]!["labelHelpTextTowns"]!;
  }

  static String get labelHelpTitleTowns {
    return _localizedValues[locale.languageCode]!["labelHelpTitleTowns"]!;
  }

  static String get labelHelpTextAchievements {
    return _localizedValues[locale.languageCode]!["labelHelpTextAchievements"]!;
  }

  static String get labelHelpTitleAchievements {
    return _localizedValues[locale.languageCode]![
        "labelHelpTitleAchievements"]!;
  }

  static String get labelHelpTextWagons {
    return _localizedValues[locale.languageCode]!["labelHelpTextWagons"]!;
  }

  static String get labelHelpTitleWagons {
    return _localizedValues[locale.languageCode]!["labelHelpTitleWagons"]!;
  }

  static String get labelHelpTextEvents {
    return _localizedValues[locale.languageCode]!["labelHelpTextEvents"]!;
  }

  static String get labelHelpTitleEvents {
    return _localizedValues[locale.languageCode]!["labelHelpTitleEvents"]!;
  }

  static String get labelHelpTextManufacturing {
    return _localizedValues[locale.languageCode]![
        "labelHelpTextManufacturing"]!;
  }

  static String get labelHelpTitleManufacturing {
    return _localizedValues[locale.languageCode]![
        "labelHelpTitleManufacturing"]!;
  }

  static String get labelHelpTitleMarket {
    return _localizedValues[locale.languageCode]!["labelHelpTitleMarket"]!;
  }

  static String get labelHelpTextMarket {
    return _localizedValues[locale.languageCode]!["labelHelpTextMarket"]!;
  }

  static String get labelHelpTitleGlobalMarket {
    return _localizedValues[locale.languageCode]![
        "labelHelpTitleGlobalMarket"]!;
  }

  static String get labelHelpTextGlobalMarket {
    return _localizedValues[locale.languageCode]!["labelHelpTextGlobalMarket"]!;
  }

  static String get labelMyAchievementProgress {
    return _localizedValues[locale.languageCode]![
        "labelMyAchievementProgress"]!;
  }

  static String get labelShortGameDescription {
    return _localizedValues[locale.languageCode]!["labelShortGameDescription"]!;
  }
}
