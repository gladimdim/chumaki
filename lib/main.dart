import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/views/starting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await AppPreferences.instance.init();
  await SoundManager.instance.initSounds();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      title: 'Дике Поле: Чумаки',
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
        child: SafeArea(
          child: Scaffold(
            body: StartingView(),
          ),
        ),
      ),
    );
  }
}
