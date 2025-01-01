import 'package:better_player/better_player.dart';
import 'package:betterplayer_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  Player({super.key, required this.media});

  final Media? media;

  late final dataSource = media == null
      ? null
      : BetterPlayerDataSource.network(
          media!.url,
          liveStream: media!.type == MediaType.live,
          // Prevents OOM
          bufferingConfiguration: BetterPlayerBufferingConfiguration(
            minBufferMs: const Duration(seconds: 10).inMilliseconds,
            maxBufferMs: const Duration(seconds: 60).inMilliseconds,
          ),
        );

  BetterPlayerConfiguration _betterPlayerConfiguration(BuildContext context) {
    return BetterPlayerConfiguration(
      autoPlay: media != null,
      aspectRatio: 16 / 9,
      // The default cupertinoTheme
      controlsConfiguration: BetterPlayerControlsConfiguration(
        fullscreenEnableIcon: CupertinoIcons.arrow_up_left_arrow_down_right,
        fullscreenDisableIcon: CupertinoIcons.arrow_down_right_arrow_up_left,
        playIcon: CupertinoIcons.play_arrow_solid,
        pauseIcon: CupertinoIcons.pause_solid,
        skipBackIcon: CupertinoIcons.gobackward_15,
        skipForwardIcon: CupertinoIcons.goforward_15,
        // Default osd background is too dark
        controlBarColor: Colors.black54,
        // Dark theme support
        overflowModalColor: Theme.of(context).colorScheme.surface,
        overflowModalTextColor: Theme.of(context).colorScheme.onSurface,
        overflowMenuIconsColor: Theme.of(context).colorScheme.onSurface,

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: BetterPlayerController(
        _betterPlayerConfiguration(context),
        betterPlayerDataSource: dataSource,
      ),
    );
  }
}
