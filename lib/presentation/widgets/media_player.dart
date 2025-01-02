import 'package:better_player/better_player.dart';
import 'package:betterplayer_demo/bloc/media_player_bloc.dart';
import 'package:betterplayer_demo/models/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({super.key});

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  late final BetterPlayerController controller = BetterPlayerController(
    const BetterPlayerConfiguration(
      autoPlay: true,
      aspectRatio: 16 / 9,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        fullscreenEnableIcon: CupertinoIcons.arrow_up_left_arrow_down_right,
        fullscreenDisableIcon: CupertinoIcons.arrow_down_right_arrow_up_left,
        playIcon: CupertinoIcons.play_arrow_solid,
        pauseIcon: CupertinoIcons.pause_solid,
        skipBackIcon: CupertinoIcons.gobackward_15,
        skipForwardIcon: CupertinoIcons.goforward_15,
        // Default osd background is too dark
        controlBarColor: Colors.black54,
      ),
    ),
  );

  void updateDataSource(Media media) {
    final dataSource = BetterPlayerDataSource.network(
      media.url,
      liveStream: media.type == MediaType.live,
      useAsmsSubtitles: true,
      useAsmsTracks: true,
      // Prevents OOM
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
        minBufferMs: const Duration(seconds: 10).inMilliseconds,
        maxBufferMs: const Duration(seconds: 60).inMilliseconds,
      ),
    );
    controller.setupDataSource(dataSource);
    // We should also seek to last played position here
    controller.seekTo(Duration.zero);
  }

  @override
  void initState() {
    super.initState();
    controller.addEventsListener(eventListener);
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

  void mediaPlayerBlocListener(BuildContext context, MediaPlayerState state) {
    if (state.hasMedia) updateDataSource(state.current!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaPlayerBloc, MediaPlayerState>(
      listener: mediaPlayerBlocListener,
      child: BetterPlayer(controller: controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeEventsListener(eventListener);
  }
}
