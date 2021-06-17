import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:flutter/material.dart';

class CityEventView extends StatelessWidget {
  final City city;
  const CityEventView({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = city.activeEvent!;
    return Container(
      child: Text(ChumakiLocalizations.getForKey(event.localizedTextKey))
    );
  }
}
