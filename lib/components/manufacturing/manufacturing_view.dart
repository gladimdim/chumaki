import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/views/inherited_company.dart';
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
    final company = InheritedCompany.of(context).company;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BorderedBottom(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GameText(
                "${ChumakiLocalizations.getForKey(mfg.fullLocalizedKey)} ${mfg.built ? "(${mfg.level})" : ""}",
                addStyle: Theme.of(context).textTheme.headline4,
              ),
              ResourceImageView(
                mfg.replenishResource(),
                showAmount: true,
                size: 72,
              ),
            ],
          ),
        ),
        Row(
          children: [
            if (mfg.canUpgrade()) Expanded(
              flex: 2,
              child: _buildActionButton(company),
            ),
            Expanded(
              flex: 5,
              child: Opacity(
                opacity: mfg.built ? 1.0 : 0.7,
                child: Image.asset(
                  mfg.imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(Company company) {
    if (!mfg.built)
      return ActionButton(
        image: Image.asset(
          "images/icons/build/build.png",
        ),
        subTitle: MoneyUnitView(mfg.priceToBuild),
        onPress: company.hasEnoughMoney(mfg.priceToBuild) ? () {
          onBuildPress!();
        } : null,
        action: TitleText(ChumakiLocalizations.labelBuild),
      );
    if (mfg.canUpgrade())
      return ActionButton(
        image:    Image.asset(
          "images/icons/upgrade/upgrade.png",
        ),
        subTitle: MoneyUnitView(mfg.priceToBuild),
        onPress: company.hasEnoughMoney(mfg.priceToBuild) ? () {
          onUpgradePress!();
        } : null,
        action: TitleText(ChumakiLocalizations.labelUpgrade),
      );
    return Container();
  }
}
