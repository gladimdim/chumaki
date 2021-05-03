import 'package:chumaki/components/weight_show.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonListItem extends StatelessWidget {
  final City city;

  WagonListItem({required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: city.wagons.map((wagon) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(Wagon.imagePath, width: 64),
            Text("Company ${wagon.name}"),
            StreamBuilder(
              stream: wagon.changes.stream,
              builder: (context, _) => WeightShow(wagon),
            ),
          ],
        );
      }).toList(),
    );
  }
}
