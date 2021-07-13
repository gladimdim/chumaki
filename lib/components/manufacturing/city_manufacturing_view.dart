import 'package:chumaki/components/manufacturing/manufacturing_view.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class CityManufacturingView extends StatelessWidget {
  final City city;
  const CityManufacturingView({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return StreamBuilder<CITY_EVENTS>(
        stream: city.changes,
        builder: (context, _) {
          return Column(
            children: city.manufacturings
                .map(
                  (mfg) => ManufacturingView(
                    mfg: mfg,
                    onBuildPress:
                        mfg.built ? null : () => onBuildPress(mfg, company),
                  ),
                )
                .toList(),
          );
        });
  }

  onBuildPress(Manufacturing mfg, Company company) {
    city.buildManufacturing(mfg, company);
  }
}
