import 'package:chumaki/components/ui/city_menu_item.dart';
import 'package:flutter/material.dart';

class CityMenuItemView extends StatelessWidget {
  final VoidCallback onPress;
  final CityMenuItem menuItem;
  final bool isSelected;

  const CityMenuItemView({
    required this.onPress,
    required this.menuItem,
    required this.isSelected,
  });

  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        border: getBorder(context),
        borderRadius: getRadius(),
        image: DecorationImage(
          image: AssetImage(
            isSelected ? "images/ui/papyrus_2.png" : "images/ui/papyrus_1.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: ClipRRect(
        borderRadius: getRadius(),
        child: OutlinedButton(
          onPressed: onPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menuItem.image,
              menuItem.label,
            ],
          ),
        ),
      ),
    );
  }

  Border getBorder(BuildContext context) {
    final border = BorderSide(
        color: isSelected ? Colors.transparent : Theme.of(context).primaryColor,
        width: 3);
    return Border(top: border, bottom: border, left: border, right: border);
  }

  BorderRadius getRadius() {
    return BorderRadius.only(
        bottomRight: Radius.circular(20), topRight: Radius.circular(20));
  }
}
