import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonResourceExchanger extends StatefulWidget {
  final Wagon wagon;
  final City city;

  WagonResourceExchanger(this.wagon, this.city);

  @override
  _WagonResourceExchangerState createState() => _WagonResourceExchangerState();
}

class _WagonResourceExchangerState extends State<WagonResourceExchanger> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: Resource.allResources.map(
        (fakeResource) {
          var wagonRes = widget.wagon.stock.resourceInStock(fakeResource);
          var cityRes = widget.city.stock.resourceInStock(fakeResource);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResourceImageView(fakeResource),
              SizedBox(
                width: 75,
                height: 64,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      wagonRes == null ? "0" : wagonRes.amount.toString(),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  var res = fakeResource.cloneWithAmount(5);
                  if (widget.city.stock.removeResource(res)) {
                    widget.wagon.stock.addResource(res);
                  }
                },
                icon: Icon(Icons.arrow_back_outlined),
              ),
              IconButton(
                onPressed: () {
                  var res = fakeResource.cloneWithAmount(5);
                  widget.city.stock.addResource(res);
                  widget.wagon.stock.removeResource(res);
                },
                icon: Icon(Icons.arrow_forward_outlined),
              ),
              SizedBox(
                width: 75,
                height: 64,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.black),
                  ),
                  child: Center(
                    child: cityRes == null
                        ? Text("Пусто")
                        : Text(
                            cityRes.amount.toString(),
                          ),
                  ),
                ),
              ),
              ResourceImageView(fakeResource),
            ],
          );
        },
      ).toList(),
    );
  }
}
