import 'package:better_player/better_player.dart';
import 'package:betterplayer_demo/bloc/media_player_bloc.dart';
import 'package:betterplayer_demo/models/media.dart';
import 'package:betterplayer_demo/presentation/widgets/media_player/player_controls.dart';
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
  final controller = BetterPlayerController(
    BetterPlayerConfiguration(
      autoPlay: true,
      aspectRatio: 16 / 9,
      // fit: BoxFit.contain,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        controlsHideTime: Durations.extralong4,
        playerTheme: BetterPlayerTheme.custom,
        customControlsBuilder: (c, _) => PlayerControls(controller: c),
      ),
    ),
  );

  void updateDataSource(Media media) async {
    if (media.url == controller.betterPlayerDataSource?.url) return;

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
    await controller.setupDataSource(dataSource);
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          BetterPlayer(controller: controller),
          // Ads Go Here
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeEventsListener(eventListener);
    controller.dispose();
  }
}
