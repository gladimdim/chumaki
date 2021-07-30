import 'dart:math';

import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/animations/scaling_widget.dart';
import 'package:chumaki/components/ui/animations/spinning_widget.dart';
import 'package:chumaki/components/wagons/wagon_avatar.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/wagons/active_wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class FromToWagonsView extends StatelessWidget {
  final City activeCity;

  const FromToWagonsView({Key? key, required this.activeCity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return StreamBuilder<COMPANY_EVENTS>(
        stream: company.changes.where((event) => [
              COMPANY_EVENTS.TASK_ENDED,
              COMPANY_EVENTS.TASK_STARTED
            ].contains(event)),
        builder: (context, snapshot) {
          return Column(
            children: [
              ...company
                  .activeIncomingRoutes(forCity: activeCity)
                  .map((activeWagon) => FromToWagonView(
                        activeWagon: activeWagon,
                      ))
                  .toList(),
              ...company
                  .activeOutcomingRoutes(forCity: activeCity)
                  .map((activeWagon) => FromToWagonView(
                        activeWagon: activeWagon,
                      ))
                  .toList(),
            ],
          );
        });
  }
}

class FromToWagonView extends StatefulWidget {
  final ActiveWagon activeWagon;
  const FromToWagonView({
    Key? key,
    required this.activeWagon,
  }) : super(key: key);

  @override
  State<FromToWagonView> createState() => _FromToWagonViewState();
}

class _FromToWagonViewState extends State<FromToWagonView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    double upper = 2 * pi;
    double lower = 0;
    _rotateController =
        AnimationController(vsync: this, upperBound: upper, lowerBound: lower)
          ..duration = Duration(seconds: 2)
          ..repeat();

    _rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateController.repeat();
      }
    });
    _rotateController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CityAvatar(
          width: 92,
          city: widget.activeWagon.from,
        ),
        ScalingWidget(
          duration: Duration(seconds: 3),
          min: 0.7,
          child: SpinningWidget(
            child: Image.asset("images/wagon/wheel.png"),
          ),
        ),
        Column(
          children: [
            WagonAvatar(wagon: widget.activeWagon.wagon),
            TitleText(ChumakiLocalizations.getForKey(
              widget.activeWagon.wagon.fullLocalizedName,
            ))
          ],
        ),
        ScalingWidget(
          duration: Duration(seconds: 3),
          min: 0.7,
          child: SpinningWidget(
            child: Image.asset("images/wagon/wheel.png"),
          ),
        ),
        CityAvatar(
          width: 92,
          city: widget.activeWagon.to,
        ),
      ],
    );
  }
}
