import 'package:chumaki/components/ui/bouncing_outlined_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';

class ResourceImageView extends StatelessWidget {
  final Resource resource;
  final bool showAmount;
  final double size;

  ResourceImageView(this.resource, {this.showAmount = false, this.size = 55.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ResizedImage(
          resource.imagePath,
          width: size.toInt(),
        ),
        if (showAmount)
          Positioned(
            bottom: 0,
            right: 0,
            child: BouncingOutlinedText(
              resource.amount.toString(),
              style: gameTextStyle,
            ),
          ),
      ],
    );
  }
}
