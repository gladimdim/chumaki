import 'package:flutter/material.dart';

class CityMenuItem {
  final String label;
  final String imagePath;
  final Widget content;
  bool isSelected = false;
  CityMenuItem({required this.label, required this.imagePath, required this.content});
}