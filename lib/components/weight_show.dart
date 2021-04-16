import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WeightShow extends StatelessWidget {
  final Wagon wagon;

  WeightShow(this.wagon);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${wagon.currentWeight} / ${wagon.totalWeightCapacity}",
      style: TextStyle(color: getColor()),
    );
  }

  Color getColor() {
    return wagon.currentWeight > wagon.totalWeightCapacity
        ? Colors.red
        : Colors.green;
  }
}
