import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/animations/scaling_widget.dart';
import 'package:chumaki/components/ui/animations/spinning_widget.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/decorated_container.dart';
import 'package:chumaki/components/wagons/wagon_avatar.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/tasks/route_task.dart';
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
                        company: company,
                      ))
                  .toList(),
              ...company
                  .activeOutcomingRoutes(forCity: activeCity)
                  .map((activeWagon) => FromToWagonView(
                        activeWagon: activeWagon,
                        company: company,
                      ))
                  .toList(),
            ],
          );
        });
  }
}

class FromToWagonView extends StatefulWidget {
  final ActiveWagon activeWagon;
  final Company company;
  const FromToWagonView({
    Key? key,
    required this.activeWagon,
    required this.company,
  }) : super(key: key);

  @override
  State<FromToWagonView> createState() => _FromToWagonViewState();
}

class _FromToWagonViewState extends State<FromToWagonView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    RouteTask fakeRoute = RouteTask(
        widget.activeWagon.from, widget.activeWagon.to,
        wagon: widget.activeWagon.wagon);
    _controller =
        AnimationController(vsync: this, duration: fakeRoute.duration);

    _controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BorderedAll(
        child: DecoratedContainer2(
          child: SizedBox(
            width: CITY_DETAILS_VIEW_WIDTH - CITY_MENU_WIDTH,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return Positioned(
                      top: 20,
                      left: _controller.value *
                          1.2 * // correction koefficient for non direct route line
                          (CITY_DETAILS_VIEW_WIDTH - CITY_MENU_WIDTH * 2),
                      child: child!,
                    );
                  },
                  child: ScalingWidget(
                    duration: Duration(seconds: 3),
                    min: 0.7,
                    child: SpinningWidget(
                      child: Image.asset("images/wagon/wheel.png"),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CityAvatar(
                      width: 92,
                      city: widget.activeWagon.from,
                    ),
                    Column(
                      children: [
                        WagonAvatar(wagon: widget.activeWagon.wagon),
                        TitleText(ChumakiLocalizations.getForKey(
                          widget.activeWagon.wagon.fullLocalizedName,
                        ))
                      ],
                    ),
                    CityAvatar(
                      width: 92,
                      city: widget.activeWagon.to,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
