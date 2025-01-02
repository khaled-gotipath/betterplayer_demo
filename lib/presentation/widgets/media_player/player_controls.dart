import 'package:better_player/better_player.dart';
import 'package:betterplayer_demo/bloc/media_player_bloc.dart';
import 'package:betterplayer_demo/models/media.dart';
import 'package:betterplayer_demo/presentation/widgets/media_player/seekbar_with_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerControls extends StatefulWidget {
  final BetterPlayerController controller;

  const PlayerControls({super.key, required this.controller});

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  BetterPlayerController get controller => widget.controller;
  bool controlsVisible = false;

  void toggleControls() async {
    setState(() {
      controlsVisible = !controlsVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addEventsListener(eventListener);
  }

  @override
  void dispose() {
    controller.removeEventsListener(eventListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.controller.controllerEventStream,
      builder: (context, _) {
        if (widget.controller.betterPlayerDataSource == null) {
          return const SizedBox();
        }

        if (_showLoadingIndicator) {
          return Center(
            child: SizedBox.fromSize(
              size: const Size.square(60),
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        return GestureDetector(
          onTap: toggleControls,
          child: AnimatedOpacity(
            duration: Durations.medium3,
            opacity: controlsVisible ? 1 : 0,
            child: ColoredBox(
              color: Colors.black.withOpacity(0.7),
              child: Column(
                children: [
                  if (controlsVisible) ...{
                    titleBar(context),
                    Expanded(child: playPauseButton(context)),
                    SeekBarWithPreview(widget.controller),
                  }
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget titleBar(BuildContext ctx) {
    final media = ctx.select<MediaPlayerBloc, Media>((v) => v.state.current!);

    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.back),
        ),
        if (widget.controller.isFullScreen) Text(media.title),
      ],
    );
  }

  void eventListener(BetterPlayerEvent event) {
    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.play:
      case BetterPlayerEventType.pause:
        setState(() {});
        break;

      default:
        break;
    }
  }

  Widget playPauseButton(BuildContext context) {
    if (widget.controller.isPlaying() == true) {
      return IconButton(
        onPressed: () => widget.controller.pause(),
        icon: const Icon(CupertinoIcons.pause, size: 52),
      );
    }
    return IconButton(
      onPressed: () => widget.controller.play(),
      icon: const Icon(CupertinoIcons.play_fill, size: 52),
    );
  }

  bool get _showLoadingIndicator =>
      widget.controller.isVideoInitialized() != true;
}
