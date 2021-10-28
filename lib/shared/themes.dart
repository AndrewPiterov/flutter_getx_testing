import 'package:flutter/material.dart';

class MyThemes {
  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    textTheme: const TextTheme(
      headline6: TextStyle(
        // fontSize: 16.0,
        fontStyle: FontStyle.normal,
      ),
      bodyText2: TextStyle(
        fontSize: 16.0,
      ),
    ),
  );

  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.yellow),
    textTheme: const TextTheme(
      headline6: TextStyle(
        // fontSize: 16.0,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        // fontSize: 16.0,
        color: Colors.black,
      ),
      // headline6: TextStyle(
      //   fontSize: 25.0,
      //   fontStyle: FontStyle.normal,
      // ),
      // bodyText2: TextStyle(
      //   fontSize: 16.0,
      // ),
    ),
    // sets the background color of the `BottomNavigationBar`
    // canvasColor: Colors.green,
    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
    primaryColor: Colors.red,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.amberAccent,
    ),
  );
}
