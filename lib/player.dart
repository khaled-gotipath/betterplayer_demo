import 'package:better_player/better_player.dart';
import 'package:betterplayer_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class Player extends StatefulWidget {
  const Player({super.key, required this.media});

  final Media? media;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  // TODO Auto retry
  BetterPlayerDataSource? dataSource;
  late final BetterPlayerController controller;

  @override
  void initState() {
    super.initState();
    if (widget.media != null) {
      dataSource = BetterPlayerDataSource.network(
        widget.media!.url,
        liveStream: widget.media!.type == MediaType.live,
        useAsmsSubtitles: true,
        useAsmsAudioTracks: true,
        useAsmsTracks: true,
        // Prevents OOM
        bufferingConfiguration: BetterPlayerBufferingConfiguration(
          minBufferMs: const Duration(seconds: 10).inMilliseconds,
          maxBufferMs: const Duration(seconds: 60).inMilliseconds,
        ),
      );
    }
    controller = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        aspectRatio: 16 / 9,
      ),
      betterPlayerDataSource: dataSource,
    );

    controller.addEventsListener(eventListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.setBetterPlayerControlsConfiguration(
        BetterPlayerControlsConfiguration(
          fullscreenEnableIcon: CupertinoIcons.arrow_up_left_arrow_down_right,
          fullscreenDisableIcon: CupertinoIcons.arrow_down_right_arrow_up_left,
          playIcon: CupertinoIcons.play_arrow_solid,
          pauseIcon: CupertinoIcons.pause_solid,
          skipBackIcon: CupertinoIcons.gobackward_15,
          skipForwardIcon: CupertinoIcons.goforward_15,
          // Default osd background is too dark
          controlBarColor: Colors.black54,
          // // Dark theme support
          overflowModalColor: Theme.of(context).colorScheme.surface,
          overflowModalTextColor: Theme.of(context).colorScheme.onSurface,
          overflowMenuIconsColor: Theme.of(context).colorScheme.onSurface,
        ),
      );
    });
  }

  void eventListener(BetterPlayerEvent event) {
    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.pause:
        WakelockPlus.disable();
        break;
      case BetterPlayerEventType.play:
        WakelockPlus.enable();
        break;

      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeEventsListener(eventListener);
  }

  @override
  Widget build(BuildContext context) => BetterPlayer(controller: controller);
}
