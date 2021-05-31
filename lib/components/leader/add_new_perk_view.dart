import 'package:chumaki/components/ui/resource_category_view.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:flutter/material.dart';

class AddNewPerkView extends StatefulWidget {
  final Leader leader;

  const AddNewPerkView(this.leader);

  @override
  _AddNewPerkViewState createState() => _AddNewPerkViewState();
}

class _AddNewPerkViewState extends State<AddNewPerkView> {
  RESOURCE_CATEGORY? _selected;

  @override
  Widget build(BuildContext context) {
    var resources = availableResources();
    return Row(
      children: [
        DropdownButton<RESOURCE_CATEGORY>(
          onChanged: _updateSelectedResource,
          value: _selected,
          items: resources
              .map(
                (category) => DropdownMenuItem(
                    child: ResourceCategoryView(category: category, width: 32,), value: category),
              )
              .toList(),
        ),
        IconButton(
            onPressed: _selected == null ? null : _addPerk,
            icon: Icon(Icons.add)),
      ],
    );
  }

  List<RESOURCE_CATEGORY> availableResources() {
    return RESOURCE_CATEGORY.values
        .where((category) => !widget.leader.hasPerkForCategory(category))
        .toList();
  }

  void _updateSelectedResource(RESOURCE_CATEGORY? selected) {
    setState(() {
      _selected = selected;
    });
  }

  void _addPerk() {
    if (_selected != null) {
      widget.leader.addPerk(PerkUnit(
        affectsResourceCategory: _selected!,
      ));
    }
  }
}
