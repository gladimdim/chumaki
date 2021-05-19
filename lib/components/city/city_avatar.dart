import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:flutter/material.dart';

class CityAvatar extends StatelessWidget {
  final City city;
  final double width;

  CityAvatar({required this.city, this.width = 32.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          city.avatarImagePath,
          width: width,
        ),
        TitleText(ChumakiLocalizations.getForKey(city.localizedKeyName)),
      ],
    );
  }
}

class SmallCityAvatar extends CityAvatar {
  final City city;

  SmallCityAvatar(this.city) : super(city: city, width: 32);
}

class CityAvatarStacked extends StatelessWidget {
  final City city;
  final double width;

  CityAvatarStacked({required this.city, this.width = 94});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: Stack(
        children: [
          Image.asset(
            city.avatarImagePath,
            width: width,
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withAlpha(130),
                ),
                child: OutlinedText(
                    ChumakiLocalizations.getForKey(city.localizedKeyName),
                    fontColor: Colors.black,
                    outlineColor: Colors.blue,
                    size: 24),
              ))
        ],
      ),
    );
  }
}
