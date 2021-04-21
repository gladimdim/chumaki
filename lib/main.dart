import 'package:chumaki/views/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme(),
      title: 'Дике Поле: Чумаки',
      home: Scaffold(
        body: MainView(),
      ),
    );
  }
}

ThemeData defaultTheme() {
  var deepColor = Colors.black;
  var mediumColor = Colors.grey[600];
  var lightColor = Colors.grey[200];
  var bgColor = Colors.grey[400];
  return ThemeData(
    primaryColor: lightColor,
    accentColor: mediumColor,
    backgroundColor: deepColor,
    buttonColor: deepColor,
    scaffoldBackgroundColor: Colors.black,
    splashColor: mediumColor,
    sliderTheme: SliderThemeData(
      valueIndicatorColor: Colors.white,
      // progress line to the right
      inactiveTrackColor: Colors.red,
      // progress line to the left
      activeTrackColor: deepColor,
      // wave color when dragging
      overlayColor: deepColor,
      // button
      thumbColor: mediumColor,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      // headline6: GoogleFonts.roboto(color: Colors.white),
      // headline4: GoogleFonts.tenorSans(
      //   color: Colors.white,
      //   fontWeight: FontWeight.bold,
      //   fontSize: 22,
      // ),
    ),
    iconTheme: IconThemeData(
      color: deepColor,
      size: 44,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return mediumColor!;
            }
            return bgColor!; // Defer to the widget's default.
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.black;
          } else if (states.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return Colors.white;
        }),
      ),
    ),
  );
}