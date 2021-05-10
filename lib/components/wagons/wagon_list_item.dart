import 'package:chumaki/components/weight_show.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonListItem extends StatelessWidget {
  final City city;
  final Wagon wagon;

  WagonListItem({required this.city, required this.wagon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(Wagon.imagePath, width: 64),
        Text("${wagon.fullLocalizedName}"),
        StreamBuilder(
          stream: wagon.changes.stream,
          builder: (context, _) => WeightShow(wagon),
        ),
      ],
    );
  }
}
