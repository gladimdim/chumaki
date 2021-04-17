import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonStockBar extends StatelessWidget {
  final Wagon wagon;

  WagonStockBar({required this.wagon});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.black),
      ),
      child: Row(
        children: wagon.stock.iterator.map<Widget>(
              (res) {
            return Container(
              width: res.totalWeight * (400 / 100),
              height: 30,
              color: res.color,
            );
          },
        ).toList(),
      ),
    );
  }
}
