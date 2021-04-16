import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/weight_show.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class WagonsInCity extends StatefulWidget {
  final City city;

  WagonsInCity({required this.city});

  @override
  _WagonsInCityState createState() => _WagonsInCityState();
}

class _WagonsInCityState extends State<WagonsInCity> {
  late List<bool> _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = List.filled(widget.city.wagons.length, false, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (i, isOpen) {
        setState(() {
          _isOpen[i] = !isOpen;
        });
      },
      children: widget.city.wagons.map((wagon) {
        return ExpansionPanel(
          backgroundColor: Colors.brown,
          isExpanded: isOpenForWagon(wagon),
          headerBuilder: (context, isOpen) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(Wagon.imagePath, width: 64),
              Text("Ватага ${wagon.name}"),
              StreamBuilder(
                stream: wagon.changes.stream,
                builder: (context, _) => WeightShow(wagon),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: wagon.changes,
            builder: (context, snap) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText("Містить"),
                DragTarget<Tuple2<City, Resource>>(onAccept: (input) {
                  var res = input.item2;
                  wagon.stock.addResource(res);
                  input.item1.stock.removeResource(res);
                }, builder: (context, candidates, rejects) {
                  List<Resource> items = List.from(wagon.stock.iterator);
                  items.addAll(candidates.map((e) => e!.item2));
                  if (wagon.stock.isEmpty) {
                    return Row(
                      children: [
                        if (items.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Перетягніть зі складу міста, щоб купити товар."),
                          ),
                        ...wagon.stock.iterator
                            .map<Widget>((res) => ResourceImageView(res))
                            .toList(),
                        ...candidates
                            .map(
                              (candidate) => ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.grey,
                                  BlendMode.saturation,
                                ),
                                child: ResourceImageView(candidate!.item2),
                              ),
                            )
                            .toList()
                      ],
                    );
                  }
                  return Row(
                    children: [
                      ...items.map<Widget>((resource) {
                        return Draggable<Tuple2<Wagon, Resource>>(
                          data: Tuple2<Wagon, Resource>(
                              wagon, resource.cloneWithAmount(5)),
                          dragAnchorStrategy: pointerDragAnchorStrategy,
                          feedback:
                              ResourceImageView(resource.cloneWithAmount(5)),
                          child: Column(
                            children: [
                              ResourceImageView(resource),
                              IconButton(
                                onPressed: () {
                                  widget.city.stock.addResource(resource);
                                  wagon.stock.removeResource(resource);
                                  setState(() {});
                                },
                                icon: Icon(Icons.arrow_downward),
                              ),
                            ],
                          ),
                        );
                      }).toList()
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  bool isOpenForWagon(Wagon wagon) {
    var index = widget.city.wagons.indexOf(wagon);
    if (_isOpen.isEmpty || index >= _isOpen.length) {
      _isOpen.addAll(List.filled(index + 1, false));
    }

    return _isOpen[index];
  }
}
