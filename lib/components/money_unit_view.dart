import 'package:chumaki/models/resources/resource.dart';
import 'package:flutter/material.dart';

class MoneyUnitView extends StatefulWidget {
  final Money money;
  final bool isEnough;
  MoneyUnitView(this.money, {this.isEnough = true});

  @override
  _MoneyUnitViewState createState() => _MoneyUnitViewState();
}

class _MoneyUnitViewState extends State<MoneyUnitView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      lowerBound: 1.0,
      upperBound: 1.5,
    );
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          _controller.reverse();
          break;
        default:
          break;
      }
    });
  }

  @override
  void didUpdateWidget(MoneyUnitView old) {
    super.didUpdateWidget(old);
    if (old.money.amount != widget.money.amount) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _controller.value,
          child: child,
        );
      },
      child: Row(
        children: [
          Image.asset(widget.money.imagePath, width: 32),
          Text(
            widget.money.amount.toStringAsFixed(1),
            style: style(widget.money.amount, context),
          )
        ],
      ),
    );
  }

  TextStyle style(double value, BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return TextStyle(color: widget.isEnough  ? Colors.green[800] : colorTheme.onSurface.withOpacity(0.38), fontWeight: FontWeight.bold, fontSize: 18);
  }
}
