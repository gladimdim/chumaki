import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonStockBar extends StatelessWidget {
  final Wagon wagon;

  final int _maxWidth = 390;

  WagonStockBar({required this.wagon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Row(
        children: wagon.stock.iterator.map<Widget>(
          (res) {
            return SizedBox(
              width: res.totalWeight * (_maxWidth / 100),
              child: Stack(
                children: [
                  Container(
                    width: res.totalWeight * (_maxWidth / 100),
                    height: 30,
                    color: res.color,
                  ),
                  if (res.totalWeight > 10)
                    Align(
                      alignment: Alignment.center,
                      child: ResourceImageView(res, size: 32,),
                    ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
