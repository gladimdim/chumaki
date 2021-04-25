import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/city.dart';
import 'package:flutter/material.dart';

class SmallCityAvatar extends StatelessWidget {
  final City city;

  SmallCityAvatar(this.city);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(city.avatarImagePath, width: 32,),
        TitleText(ChumakiLocalizations.getForKey(city.localizedKeyName)),
      ],
    );
  }
}
