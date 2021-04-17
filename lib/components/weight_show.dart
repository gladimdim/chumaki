import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WeightShow extends StatelessWidget {
  final Wagon wagon;

  WeightShow(this.wagon);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${wagon.currentWeight} / ${wagon.totalWeightCapacity}",
      style: getStyle()
    );
  }

  TextStyle getStyle() {
    return wagon.currentWeight > wagon.totalWeightCapacity
        ? TextStyle(color: Colors.red,)
        : TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  }
}
