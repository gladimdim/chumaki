
import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class SmallCityAvatar extends CityAvatar {
  final City city;
  final bool showName;

  SmallCityAvatar(this.city, {this.showName = true})
      : super(city: city, showName: showName, width: 32);
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
          ResizedImage(
            city.avatarImagePath,
            width: width,
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: lightGrey.withAlpha(130),
                ),
                child: OutlinedText(
                    ChumakiLocalizations.getForKey(city.localizedKeyName),
                    style: gameTextStyle,
                    size: 32),
              ))
        ],
      ),
    );
  }
}
