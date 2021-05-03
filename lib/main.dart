import 'package:chumaki/views/starting_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дике Поле: Чумаки',
      home: Scaffold(
        body: StartingView(),
      ),
    );
  }
}
