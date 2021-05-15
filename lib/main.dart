import 'package:chumaki/theme.dart';
import 'package:chumaki/views/starting_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      title: 'Дике Поле: Чумаки',
      home: Scaffold(
        body: StartingView(),
      ),
    );
  }
}
