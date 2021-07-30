import 'package:chumaki/models/resources/resource_category.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:flutter/material.dart';

class WagonAvatar extends StatelessWidget {
  const WagonAvatar({Key? key, required this.wagon}) : super(key: key);
  final Wagon wagon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipOval(
            child: Image.asset(wagon.getImagePath(), width: 128),
          ),
        ),
        wagon.leader == null
            ? Container()
            : StreamBuilder(
                stream: wagon.leader!.changes,
                builder: (context, _) => Positioned(
                  right: 0,
                  bottom: 0,
                  child: Row(
                    children: wagon.leader!.perks
                        .map(
                          (perk) => Image.asset(
                            categoryToImagePath(perk.affectsResourceCategory),
                            width: 32,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
      ],
    );
  }
}
