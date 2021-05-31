import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class AddNewPerkView extends StatefulWidget {
  final Leader leader;

  const AddNewPerkView(this.leader);

  @override
  _AddNewPerkViewState createState() => _AddNewPerkViewState();
}

class _AddNewPerkViewState extends State<AddNewPerkView> {
  RESOURCES? _selected;

  @override
  Widget build(BuildContext context) {
    var resources = availableResources();
    return Row(
      children: [
        DropdownButton<RESOURCES>(
          onChanged: _updateSelectedResource,
          value: _selected,
          items: resources
              .map(
                (resource) => DropdownMenuItem(
                    child: ResourceImageView(
                      Resource.fromType(resource),
                      size: 32,
                    ),
                    value: resource),
              )
              .toList(),
        ),
        IconButton(
            onPressed: _selected == null ? null : _addPerk,
            icon: Icon(Icons.add)),
      ],
    );
  }

  List<RESOURCES> availableResources() {
    return RESOURCES.values
        .where((resource) =>
            !widget.leader.doesAffectResource(Resource.fromType(resource)))
        .toList();
  }

  void _updateSelectedResource(RESOURCES? selected) {
    setState(() {
      _selected = selected;
    });
  }

  void _addPerk() {
    if (_selected != null) {
      widget.leader.addPerk(
          PerkUnit(affectsResource: _selected!, sellValue: 1.1, buyValue: 0.9));
    }
  }
}
