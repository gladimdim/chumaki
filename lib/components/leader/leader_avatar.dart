import 'package:chumaki/models/leaders/leaders.dart';
import 'package:flutter/material.dart';

class LeaderAvatar extends StatelessWidget {
  final Leader? leader;

  const LeaderAvatar({Key? key, this.leader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person = leader;
    final imagePath = person == null ? "images/icons/unknown/unknown.png" : person.imagePath;
    return ClipOval(
      child: Image.asset(imagePath, width: 64),
    );
  }
}
