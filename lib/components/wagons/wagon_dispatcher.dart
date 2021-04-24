import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonDispatcher extends StatelessWidget {
  final Wagon wagon;
  final City city;

  WagonDispatcher({required this.wagon, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: city.connectsTo().map(
        (toCity) {
          return TextButton(
            child: SmallCityAvatar(toCity),
            onPressed: () => dispatch(toCity),
          );
        },
      ).toList(),
    );
  }

  void dispatch(City to) {
    Company.instance.startTask(from: city, to: to, withWagon: wagon);
  }
}
