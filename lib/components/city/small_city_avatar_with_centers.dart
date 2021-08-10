import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:flutter/material.dart';

class SmallCityAvatarWithCenters extends StatelessWidget {
  final City city;
  final bool showName;

  const SmallCityAvatarWithCenters(
      {Key? key, required this.city, this.showName = true})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          city.avatarImagePath,
          width: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              TitleText(ChumakiLocalizations.getForKey(city.localizedKeyName)),
              Row(
                children: city.manufacturings
                    .map((mfg) => ResourceImageView(
                          mfg.produces,
                          size: 32,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
