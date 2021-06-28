import 'package:flutter/material.dart';

class CityMenuItem {
  final String menuKey;
  final Widget label;
  final Widget image;
  final Widget content;
  final VoidCallback? playSoundOnOpen;

  CityMenuItem(
      {required this.menuKey,
      required this.label,
      required this.image,
      required this.content,
      this.playSoundOnOpen});
}
