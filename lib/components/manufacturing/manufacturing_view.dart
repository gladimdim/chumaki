import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:flutter/material.dart';

class ManufacturingView extends StatelessWidget {
  final Manufacturing mfg;
  final VoidCallback? onBuildPress;
  const ManufacturingView({Key? key, required this.mfg, this.onBuildPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(ChumakiLocalizations.getForKey(mfg.fullLocalizedKey)),
        Stack(
          children: [
            Image.asset(
              mfg.imagePath,
              fit: BoxFit.fill,
            ),
            if (onBuildPress != null)
              Positioned(
                bottom: 20,
                left: 10,
                child: ActionButton(
                    image: Image.asset("images/icons/money/money_2d.png",
                        width: 128),
                    subTitle: MoneyUnitView(mfg.priceToBuild),
                    action: Text(ChumakiLocalizations.labelBuild),
                    onPress: () {
                      onBuildPress!();
                    }),
              ),
          ],
        ),
      ],
    );
  }
}
