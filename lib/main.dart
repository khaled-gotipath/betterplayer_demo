import 'package:betterplayer_demo/presentation/constants/app_theme.dart';
import 'package:betterplayer_demo/presentation/screens/player_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.normal,
      scrollBehavior: AppTheme.scrollBehavior,
      home: const PlayerScreen(),
    ),
  );
}
