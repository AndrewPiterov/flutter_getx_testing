import 'package:flutter/material.dart';

class MyThemes {
  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 25.0, fontStyle: FontStyle.normal),
      bodyText2: TextStyle(
        fontSize: 16.0,
      ),
    ),
  );

  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
  );
}
