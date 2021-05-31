import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:flutter/material.dart';

class PerkUnitView extends StatelessWidget {
  final PerkUnit perk;
  const PerkUnitView(this.perk);

  @override
  Widget build(BuildContext context) {
    return Image.asset(categoryToImagePath(perk.affectsResourceCategory), width: 32,);
  }
}
