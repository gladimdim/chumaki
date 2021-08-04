import 'package:chumaki/models/logger/logger.dart';
import 'package:flutter/material.dart';

abstract class AchievementBase {
  final String localizedKey;
  final String iconPath;
  bool achieved = false;

  AchievementBase({
    required this.localizedKey,
    required this.iconPath,
    this.achieved = false,
  });

  Widget toWidget(Logger logger);

  Map<String, dynamic> toJson() {
    return {
      "localizedKey": localizedKey,
      "iconPath": iconPath,
      "achieved": achieved,
    };
  }

  bool processChange(Logger logger);
}

