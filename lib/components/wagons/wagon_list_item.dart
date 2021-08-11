import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/components/weight_show.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:flutter/material.dart';

class WagonListItem extends StatelessWidget {
  final City city;
  final Wagon wagon;
  final bool showWeight;
  WagonListItem(
      {required this.city, required this.wagon, this.showWeight = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResizedImage(Wagon.imagePath, width: 64),
        TitleText("${wagon.fullLocalizedName}"),
        if (showWeight)
          StreamBuilder(
            stream: wagon.changes.stream,
            builder: (context, _) => WeightShow(wagon),
          ),
      ],
    );
  }
}
