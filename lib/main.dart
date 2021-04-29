import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:chumaki/views/main_view.dart';
import 'package:chumaki/views/starting_view.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/models/company.dart';
import 'package:async/async.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AsyncMemoizer _appPreferencesInitter = AsyncMemoizer();

  _appPreferencesInit() {
    return _appPreferencesInitter.runOnce(() => AppPreferences.instance.init());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дике Поле: Чумаки',
      home: Scaffold(
        body: StartingView(),
      ),
    );
  }
}
