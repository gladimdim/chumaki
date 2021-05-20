import 'package:chumaki/components/city/buy_new_wagon_view.dart';
import 'package:chumaki/components/city/city_wagon_trade_list.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
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
    return StreamBuilder(
      stream: company.changes.where((event) =>
          event == COMPANY_EVENTS.MONEY_REMOVED ||
          event == COMPANY_EVENTS.MONEY_ADDED),
      builder: (context, snapshot) => BuyNewWagonView(widget.city),
    );
  }
}
