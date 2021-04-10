import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:flutter/material.dart';

class SelectedCityView extends StatelessWidget {
  final City city;

  SelectedCityView({required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(city.name),
        ...city.connectsTo().map(
          (city) {
            return Text("Connects to: ${city.name}");
          },
        ),
        Text("In: "),
        ...Company.instance.tasks.where((task) => task.to.equalsTo(city)).map((e) => Text("Wagon"),),
        Text("Out: "),
        ...Company.instance.tasks.where((task) => task.from.equalsTo(city)).map((e) => Text("Wagon"),),
      ],
    );
  }
}
