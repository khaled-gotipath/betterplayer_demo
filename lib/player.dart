import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,

        ),
        betterPlayerDataSource: BetterPlayerDataSource.network(
          url,
          bufferingConfiguration: BetterPlayerBufferingConfiguration(
            minBufferMs: Duration(seconds: 10).inMilliseconds,
            maxBufferMs: Duration(seconds: 60).inMilliseconds,
          ),
        ),
      ),
    );
  }
}
