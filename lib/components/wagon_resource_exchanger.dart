import 'package:chumaki/components/resource_amount_selector.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/components/wagon_stock_bar.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
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
  int amountTradeValue = 5;
  double _maxWidth = 315;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WagonStockBar(
          wagon: widget.wagon,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 50,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ResourceAmountSelector(
                  onSelectionChange: onAmountChanged,
                  value: amountTradeValue,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 120,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("images/resources/money/money.png"),
                        StreamBuilder(
                            stream: Company.instance.changes,
                            builder: (context, snap) {
                              return Text(
                                  Company.instance.getMoney().toString());
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ...Resource.allResources
            .where(
          (fakeResource) =>
              widget.wagon.stock.hasResource(fakeResource) ||
              widget.city.stock.hasResource(fakeResource),
        )
            .map(
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
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          wagonRes == null
                              ? "Пусто"
                              : wagonRes.amount.toString(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 5,
                          color: fakeResource.color,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            "images/wagon/wagon.png",
                            width: 50,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          var res =
                              fakeResource.cloneWithAmount(amountTradeValue);
                          if (widget.wagon.canFitNewResource(res)) {
                            widget.city.sellResource(
                                resource: res, toWagon: widget.wagon);
                          }
                        },
                        icon: Icon(Icons.arrow_back_outlined, size: 32),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/resources/money/money.png",
                            width: 22,
                          ),
                          Text(
                            widget.city.prices
                                .sellPriceForResource(fakeResource,
                                    withAmount: amountTradeValue)
                                .toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          var res =
                              fakeResource.cloneWithAmount(amountTradeValue);
                          widget.city.buyResource(
                              resource: res, fromWagon: widget.wagon);
                        },
                        icon: Icon(Icons.arrow_forward_outlined, size: 32),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/resources/money/money.png",
                            width: 22,
                          ),
                          Text(
                            widget.city.prices
                                .buyPriceForResource(fakeResource,
                                    withAmount: amountTradeValue)
                                .toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 75,
                  height: 64,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.black),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: cityRes == null
                              ? Text("Пусто")
                              : Text(
                                  cityRes.amount.toString(),
                                ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              "images/cities/church.png",
                              width: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ResourceImageView(fakeResource),
              ],
            );
          },
        ).toList(),
      ],
    );
  }

  void onAmountChanged(int newValue) {
    setState(() {
      amountTradeValue = newValue;
    });
  }
}
