import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';

class ResourceAmountSelector extends StatelessWidget {
  final Function(int) onSelectionChange;
  final int value;

  ResourceAmountSelector(
      {required this.onSelectionChange, required this.value});

  final List<int> amounts = [1, 2, 5, 10, 50];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: amounts.map((amount) {
        return Column(
          children: [
            Radio<int>(
              value: amount,
              groupValue: value,
              onChanged: (int? value) {
                if (value != null) {
                  onSelectionChange(value);
                }
              },
            ),
            Text(amount.toString()),
          ],
        );
      }).toList(),
    );
  }
}
