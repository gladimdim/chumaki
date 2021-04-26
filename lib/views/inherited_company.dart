import 'package:chumaki/models/company.dart';
import 'package:flutter/material.dart';

class InheritedCompany extends InheritedWidget {
  final Widget child;
  final Company company;
  InheritedCompany({required this.company, required this.child}) : super(child: child);

  @override
  updateShouldNotify(oldWidget) => true;

  static InheritedCompany of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCompany>()!;
  }
}
