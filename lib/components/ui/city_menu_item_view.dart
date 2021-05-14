import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/city_menu_item.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CityMenuItemView extends StatelessWidget {
  final VoidCallback onPress;
  final CityMenuItem menuItem;

  const CityMenuItemView({
    required this.onPress,
    required this.menuItem,
  });

  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: menuItem.isSelected ? NeumorphicBoxShape.rect() : NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
        color: light,
      ),
      onPressed: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            menuItem.imagePath,
            width: 128,
          ),
          TitleText(menuItem.label),
        ],
      ),
    );
  }
}
