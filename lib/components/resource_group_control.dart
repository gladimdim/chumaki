import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/title_text.dart';

class ResourceGroupControl extends StatelessWidget {
  final Resource? resource;
  final Resource originalResource;
  final String titleImage;

  ResourceGroupControl({required this.resource, required this.titleImage, required this.originalResource});

  @override
  Widget build(BuildContext context) {
    var res = resource;
    return GroupedControl(
      title: Image.asset(
        titleImage,
        width: 30,
      ),
      titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
      child: TitleText(
        res == null ? "Пусто" : res.amount.toString(),
      ),
      width: 90,
      borderColor: originalResource.color,
      borderWidth: 3,
      height: 100,
    );
  }
}
