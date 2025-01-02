import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get normal {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        accentColor: const Color(0xff6e50da),
        cardColor: const Color(0xff333333),
        errorColor: Colors.red,
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
    );
  }

  static ScrollBehavior get scrollBehavior {
    return const MaterialScrollBehavior().copyWith(
        // physics: const BouncingScrollPhysics(),
        );
  }
}
