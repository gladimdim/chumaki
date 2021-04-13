import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';

class ResourceImageView extends StatelessWidget {
  final Resource resource;

  ResourceImageView(this.resource);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(resource.imagePath, width: 64),
        Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            resource.amount.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.yellow,
            ),
          ),
        ),
      ],
    );
  }
}
