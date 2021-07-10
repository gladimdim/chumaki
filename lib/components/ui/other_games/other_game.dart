import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherGame {
  final String image;
  final String titleKey;
  final String urlEn;
  final String urlUkr;

  OtherGame({
    required this.image,
    required this.titleKey,
    required this.urlEn,
    required this.urlUkr,
  });

  void openUrlFor(Locale locale) async {
    var name = locale.languageCode;
    var url = urlEn;
    if (name == "uk") {
      url = urlUkr;
    }
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static List<OtherGame> allGames() {
    return [
      OtherGame(
        image: "images/other/locadeserta_hex.png",
        titleKey: "labelLocaDesertaHex",
        urlUkr: "http://locadeserta.com/locadesertahex/",
        urlEn: "http://locadeserta.com/locadesertahex/index_en.html",
      ),
      OtherGame(
        image: "images/other/loca_deserta.png",
        titleKey: "labelLocaDeserta",
        urlUkr: "http://locadeserta.com/interactive",
        urlEn: "http://locadeserta.com/interactive/index_en.html",
      ),
      OtherGame(
        image: "images/other/sloboda.png",
        titleKey: "labelLocaDesertaSloboda",
        urlUkr: "http://locadeserta.com/citybuilding",
        urlEn: "http://locadeserta.com/citybuilding/index_en.html",
      ),
    ];
  }
}
