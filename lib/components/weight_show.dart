import 'package:chumaki/components/ui/bouncing_normal_text.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WeightShow extends StatelessWidget {
  final Wagon wagon;

  WeightShow(this.wagon);

  @override
  Widget build(BuildContext context) {
    return BouncingNormalText(
      "${wagon.currentWeight} / ${wagon.totalWeightCapacity}",
    );
  }
}
