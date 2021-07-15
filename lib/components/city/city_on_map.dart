import 'package:chumaki/components/city/AnimatedFlag.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/game_canvas_view.dart';
import 'package:flutter/material.dart';

class CityOnMap extends StatelessWidget {
  final City city;
  final MAP_MODE mapMode;

  const CityOnMap(this.city, {required this.mapMode});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: city.changes,
      builder: (context, snapshot) => Opacity(
        opacity: city.isUnlocked() ? 1 : 0.6,
        child: SizedBox(
          width: CITY_SIZE * city.size,
          height: CITY_SIZE * city.size,
          child: Stack(
            children: [
              Positioned.fill(
                  child: AnimatedFlag(
                      topColor: Colors.red,
                      bottomColor: Colors.green,
                      animate: city.activeEvent != null)),
              // if (city.activeEvent != null)
              //   Transform.translate(
              //       offset:
              //           Offset(CITY_SIZE.toDouble() * city.size / 2 - 30, -50),
              //       child: SpinningStar()),
              Center(
                child: _avatarForMode(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withAlpha(180),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      ChumakiLocalizations.getForKey(city.localizedKeyName),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 8 * city.size,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              if (city.size > 1)
                Align(
                  alignment: Alignment.topRight,
                  child: Wrap(
                    children: [
                      Image.asset(
                        Wagon.imagePath,
                        width: 15 * city.size,
                      ),
                      Text(
                        city.wagons.length.toString(),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarForMode() {
    if (mapMode == MAP_MODE.CITY) {
      return Image.asset(city.avatarImagePath,
          width: CITY_SIZE.toDouble() * city.size);
    } else {
      final base = 80;
      final count = city.manufacturings.length;
      final changePerResource = 16;
      final koef =
          (base - changePerResource * count).toDouble() * city.size * 0.5;
      // final sizeAdjust =
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: city.manufacturings
            .map((e) => ResourceImageView(e.produces, size: koef))
            .toList(),
      );
    }
  }
}
