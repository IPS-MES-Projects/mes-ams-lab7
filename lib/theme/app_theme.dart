import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.amber.shade700,
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.amber.shade700,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.amber.shade900,
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: Colors.amber.shade900,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
    );
  }
}
