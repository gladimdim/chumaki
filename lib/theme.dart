import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkGrey = Colors.grey[800]!;
final mediumGrey = Colors.grey[500]!;
final background = Colors.grey[300]!;
final lightGrey = Colors.grey[100]!;
final black = Colors.black;

final mainTheme = ThemeData(
  primaryColor: black,
  buttonTheme: ButtonThemeData(
    buttonColor: background,
  ),
  backgroundColor: background,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith((states) {
        return GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        );
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) return mediumGrey;
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) return lightGrey;
          if (states.contains(MaterialState.disabled)) return mediumGrey.withOpacity(0.6);
          return background;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return background;
        } else if (states.contains(MaterialState.pressed)) {
          return darkGrey;
        }
        return Colors.black;
      }),
    ),
  ),
  textTheme: TextTheme(
    headline6: GoogleFonts.tenorSans(
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);
