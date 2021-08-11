import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:flutter/material.dart';

class PerkUnitView extends StatelessWidget {
  final PerkUnit perk;
  const PerkUnitView(this.perk);

  @override
  Widget build(BuildContext context) {
    return ResizedImage(categoryToImagePath(perk.affectsResourceCategory), width: 32,);
  }
}
