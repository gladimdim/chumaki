import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:flutter/material.dart';

class CityAvatar extends StatelessWidget {
  final City city;
  final double width;
  final bool showName;

  CityAvatar({required this.city, this.width = 32.0, this.showName = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Image.asset(
            city.avatarImagePath,
            width: width,
          ),
        if (showName) Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              TitleText(ChumakiLocalizations.getForKey(city.localizedKeyName)),
        ),
      ],
    );
  }
}
