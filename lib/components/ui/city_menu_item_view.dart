import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/city_menu_item.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class CityMenuItemView extends StatelessWidget {
  final VoidCallback onPress;
  final CityMenuItem menuItem;

  const CityMenuItemView({
    required this.onPress,
    required this.menuItem,
  });

  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        border: getBorder(),
        borderRadius: getRadius(),
        color: !menuItem.isSelected ? Colors.grey[300] : null,
      ),
      child: TextButton(
        onPressed: onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              menuItem.imagePath,
              width: 128,
            ),
            DefaultTextStyle(style: TextStyle(), child: TitleText(menuItem.label), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

  Border getBorder() {
    final border = BorderSide(color: Colors.black, width: 3);
    return menuItem.isSelected ? Border( left: border,) :  Border(top: border, bottom: border, left: border, right: border);
  }

  BorderRadius? getRadius() {
    return menuItem.isSelected ? null : BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20));
  }
}
