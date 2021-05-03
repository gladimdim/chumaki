import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/wagons/wagon_dispatcher.dart';
import 'package:chumaki/components/wagons/wagon_resource_exchanger.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonDetails extends StatelessWidget {
  final Wagon wagon;
  final City city;
  WagonDetails({required this.wagon, required this.city});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: wagon.changes,
      builder: (context, snap) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText("Відправити"),
          WagonDispatcher(wagon: wagon, city: city),
          TitleText("Валка містить"),
          WagonResourceExchanger(wagon, city),
        ],
      ),
    );
  }
}
