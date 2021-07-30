import 'package:chumaki/components/city/buy_new_wagon_view.dart';
import 'package:chumaki/components/city/call_wagon_to_city_view.dart';
import 'package:chumaki/components/wagons/from_to_wagon_view.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class CityWagonsView extends StatefulWidget {
  final City city;

  CityWagonsView({required this.city});

  @override
  _CityWagonsViewState createState() => _CityWagonsViewState();
}

class _CityWagonsViewState extends State<CityWagonsView> {
  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return Column(
      children: [
        BuyNewWagonView(widget.city),
        CallWagonToCityView(toCity: widget.city, company: company),
        FromToWagonsView(activeCity: widget.city),
      ],
    );
  }
}
