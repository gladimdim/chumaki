import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class PerkUnitView extends StatelessWidget {
  final PerkUnit perk;
  const PerkUnitView(this.perk);

  @override
  Widget build(BuildContext context) {
    final image = ResourceImageView(Resource.fromType(perk.affectsResource), size: 32,);
    return image;
  }
}
