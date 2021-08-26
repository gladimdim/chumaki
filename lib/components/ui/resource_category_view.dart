import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:flutter/material.dart';

class ResourceCategoryView extends StatelessWidget {
  final RESOURCE_CATEGORY category;
  final double width;
  const ResourceCategoryView({required this.category, this.width = 16});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ResizedImage(categoryToImagePath(category), width: width),
        Text(
          ChumakiLocalizations.getForKey(
            resourceCategoryToLocalizedKey(category),
          ),
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
