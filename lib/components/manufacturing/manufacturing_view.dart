import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:flutter/material.dart';

class ManufacturingView extends StatelessWidget {
  final Manufacturing mfg;
  final VoidCallback? onBuildPress;
  final VoidCallback? onUpgradePress;
  const ManufacturingView({
    Key? key,
    required this.mfg,
    this.onBuildPress,
    this.onUpgradePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BorderedBottom(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${ChumakiLocalizations.getForKey(mfg.fullLocalizedKey)} ${mfg.built ? "(${mfg.level})" : ""}",
                style: Theme.of(context).textTheme.headline3,
              ),
              ResourceImageView(
                mfg.replenishResource(),
                showAmount: true,
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Opacity(
              opacity: mfg.built ? 1.0 : 0.7,
              child: Image.asset(
                mfg.imagePath,
                fit: BoxFit.fill,
              ),
            ),
            if (!mfg.built)
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
                  },
                ),
              ),
            if (mfg.canUpgrade())
              Positioned(
                bottom: 20,
                left: 10,
                child: ActionButton(
                  image: Image.asset("images/icons/money/money_2d.png",
                      width: 128),
                  subTitle: MoneyUnitView(mfg.priceToBuild),
                  action: Text(ChumakiLocalizations.labelUpgrade),
                  onPress: () {
                    onUpgradePress!();
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
