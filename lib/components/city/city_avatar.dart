import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ResizedImage(
          city.avatarImagePath,
          width: width.toInt(),
        ),
        if (showName)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TitleText(
                ChumakiLocalizations.getForKey(city.localizedKeyName)),
          ),
      ],
    );
  }
}
