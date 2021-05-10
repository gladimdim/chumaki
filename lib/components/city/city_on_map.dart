import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/game_canvas_view.dart';
import 'package:flutter/material.dart';

class CityOnMap extends StatelessWidget {
  final City city;

  const CityOnMap(this.city);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: city.changes,
      builder: (context, snapshot) => Opacity(
        opacity: city.isUnlocked() ? 1 : 0.6,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.yellow,
                Colors.yellow,
                Colors.blue,
                Colors.blue,
              ],
              stops: [0, 0.49, 0.51, 1],
            ),
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          width: CITY_SIZE * city.size,
          height: CITY_SIZE * city.size,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(city.avatarImagePath,
                    width: CITY_SIZE.toDouble() * city.size),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  ChumakiLocalizations.getForKey(city.localizedKeyName),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8 * city.size,
                      backgroundColor: Colors.white,
                      fontWeight: FontWeight.bold),
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
}
