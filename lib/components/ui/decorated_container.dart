import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final String imagePath;
  final Widget child;
  const DecoratedContainer(
      {Key? key, required this.imagePath, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
      ),
      child: child,
    );
  }
}

class DecoratedContainer1 extends DecoratedContainer {
  final Widget child;
  DecoratedContainer1({required this.child})
      : super(imagePath: "images/ui/papyrus_1.png", child: child);
}

class DecoratedContainer2 extends DecoratedContainer {
  final Widget child;
  DecoratedContainer2({required this.child})
      : super(imagePath: "images/ui/papyrus_2.png", child: child);
}

class DecoratedContainer3 extends DecoratedContainer {
  final Widget child;
  DecoratedContainer3({required this.child})
      : super(imagePath: "images/ui/papyrus_3.png", child: child);
}
