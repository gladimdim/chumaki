import 'package:flutter/material.dart';

class CityMenuItem {
  final Widget label;
  final Widget image;
  final Widget content;
  bool isSelected = false;
  CityMenuItem({required this.label, required this.image, required this.content});
}