import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${ChumakiLocalizations.getForKey(mfg.fullLocalizedKey)} ${mfg.built ? "(${mfg.level})" : ""}",
                style: Theme.of(context).textTheme.headline5,
              ),
              ResourceImageView(
                mfg.replenishResource(),
                showAmount: true,
              ),
              if (!mfg.built)
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/icons/build/build.png",
                          width: 44,
                        ),
                        MoneyUnitView(mfg.priceToBuild),
                      ],
                    ),
                  ),
                  onPressed: () {
                    onBuildPress!();
                  },
                ),
              if (mfg.canUpgrade())
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/icons/upgrade/upgrade.png",
                          width: 44,
                        ),
                        MoneyUnitView(mfg.priceToBuild),
                      ],
                    ),
                  ),
                  onPressed: () {
                    onUpgradePress!();
                  },
                ),
            ],
          ),
        ),
        Opacity(
          opacity: mfg.built ? 1.0 : 0.7,
          child: Image.asset(
            mfg.imagePath,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
