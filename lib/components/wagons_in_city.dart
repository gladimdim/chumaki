import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/wagon_resource_exchanger.dart';
import 'package:chumaki/components/weight_show.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonsInCity extends StatefulWidget {
  final City city;

  WagonsInCity({required this.city});

  @override
  _WagonsInCityState createState() => _WagonsInCityState();
}

class _WagonsInCityState extends State<WagonsInCity> {
  final List<bool> _isOpen = List.filled(100, false, growable: true);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (i, isOpen) {
        setState(() {
          _isOpen[i] = !isOpen;
        });
      },
      children: widget.city.wagons.map((wagon) {
        return ExpansionPanel(
          backgroundColor: Colors.grey[400],
          isExpanded: isOpenForWagon(wagon),
          headerBuilder: (context, isOpen) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(Wagon.imagePath, width: 64),
              Text("Ватага ${wagon.name}"),
              StreamBuilder(
                stream: wagon.changes.stream,
                builder: (context, _) => WeightShow(wagon),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: wagon.changes,
            builder: (context, snap) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText("Містить"),
                WagonResourceExchanger(wagon, widget.city),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  bool isOpenForWagon(Wagon wagon) {
    var index = widget.city.wagons.indexOf(wagon);
    if (_isOpen.isEmpty || index >= _isOpen.length) {
      _isOpen.addAll(List.filled(index + 1, false));
    }

    return _isOpen[index];
  }
}
