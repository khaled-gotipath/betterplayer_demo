import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class SeekBarWithPreview extends StatelessWidget {
  final BetterPlayerController controller;

  const SeekBarWithPreview(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: 0,
      onChanged: (value) {
        // controller.seekTo(Duration(seconds: value.toInt()));
      },
      onChangeEnd: (value) {
        controller.seekTo(Duration(seconds: value.toInt()));
      },
    );
  }
}
