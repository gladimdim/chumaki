import 'package:chumaki/components/manufacturing/manufacturing_view.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class CityManufacturingView extends StatelessWidget {
  final City city;
  const CityManufacturingView({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: city.produces
          .map(
            (resource) => ManufacturingView(
              mfg: manufacturingForResource(resource),
              onBuildPress: () => onBuildPress(resource),
            ),
          )
          .toList(),
    );
  }

  onBuildPress(Resource resources) {
    print("Should be built");
  }
}
