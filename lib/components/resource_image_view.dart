import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';

class ResourceImageView extends StatelessWidget {
  final Resource resource;
  final bool showAmount;

  ResourceImageView(this.resource, {this.showAmount = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(resource.imagePath, width: 64),
        if (showAmount) Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            resource.amount.toString(),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
