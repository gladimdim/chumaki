import 'package:chumaki/components/ui/city_menu_item.dart';
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
        border: getBorder(context),
        borderRadius: getRadius(),
      ),
      child: ClipRRect(
        borderRadius: getRadius(),
        child: TextButton(
          onPressed: onPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                menuItem.imagePath,
                width: 128,
              ),
              menuItem.label,
            ],
          ),
        ),
      ),
    );
  }

  Border getBorder(BuildContext context) {
    final border = BorderSide(color: menuItem.isSelected ? Colors.transparent : Theme.of(context).primaryColor, width: 3);
    return Border(top: border, bottom: border, left: border, right: border);
  }

  BorderRadius getRadius() {
    return BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20));
  }
}
