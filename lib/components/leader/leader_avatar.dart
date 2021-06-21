import 'package:chumaki/models/leaders/leaders.dart';
import 'package:flutter/material.dart';

class LeaderAvatar extends StatelessWidget {
  final Leader leader;

  const LeaderAvatar({Key? key, required this.leader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(leader.imagePath, width: 64),
    );
  }
}
