import 'package:chumaki/views/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дике Поле: Чумаки',
      home: Scaffold(
        body: MainView(),
      ),
    );
  }
}
