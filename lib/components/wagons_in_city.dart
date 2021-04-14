import 'package:chumaki/components/stock_view.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonsInCity extends StatefulWidget {
  final City city;

  WagonsInCity({required this.city});

  @override
  _WagonsInCityState createState() => _WagonsInCityState();
}

class _WagonsInCityState extends State<WagonsInCity> {
  late List<bool> _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = List.filled(widget.city.wagons.length, false, growable: true);
  }

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
          backgroundColor: Colors.brown,
          isExpanded: isOpenForWagon(wagon),
          headerBuilder: (context, isOpen) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(Wagon.imagePath, width: 64),
              Row(
                children: [
                  Text("Ватага ${wagon.name}"),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              StockView(
                wagon.stock,
              ),
            ],
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
