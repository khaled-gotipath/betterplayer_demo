import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get normal {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        primary: Colors.red,
        primaryFixed: Colors.red,
        brightness: Brightness.dark,
        surface: Colors.black,
      ),
    );
  }

  static ScrollBehavior get scrollBehavior {
    return const MaterialScrollBehavior().copyWith(
      // physics: const BouncingScrollPhysics(),
    );
  }
}
