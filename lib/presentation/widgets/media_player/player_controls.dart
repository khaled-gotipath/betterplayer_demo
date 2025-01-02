import 'package:better_player/better_player.dart';
import 'package:betterplayer_demo/presentation/widgets/media_player/seekbar_with_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerControls extends StatefulWidget {
  final BetterPlayerController controller;

  const PlayerControls({super.key, required this.controller});

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  BetterPlayerController get controller => widget.controller;
  bool controlsVisible = false;
  bool lockedUI = false;

  void toggleControls() {
    setState(() => controlsVisible = !controlsVisible);
  }

  void toggleVideoFit() {
    final next = (controller.getFit().index + 1) % BoxFit.values.length;
    controller.setOverriddenFit(BoxFit.values[next]);
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.controllerEventStream,
      builder: (context, _) {
        if (controller.betterPlayerDataSource == null) {
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
            child: Material(
              color: Colors.black.withOpacity(0.7),
              child: Padding(
                padding: EdgeInsets.all(adaptivePadding),
                child: Column(
                  children: [
                    if (controlsVisible) ...{
                      titleBar(context),
                      Expanded(child: playPauseButton(context)),
                      SeekBarWithPreview(widget.controller),
                      bottomActions(context),
                    }
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double get adaptivePadding => controller.isFullScreen ? 16 : 4;

  Widget titleBar(BuildContext ctx) {
    // final media = ctx.select<MediaPlayerBloc, Media>((v) => v.state.current!);

    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.back),
        ),
        // if (controller.isFullScreen) Text(media.title),
      ],
    );
  }

  Widget playPauseButton(BuildContext context) {
    if (controller.isPlaying() == true) {
      return IconButton(
        onPressed: () => controller.pause(),
        icon: const Icon(CupertinoIcons.pause, size: 52),
      );
    }
    return IconButton(
      onPressed: () => controller.play(),
      icon: const Icon(CupertinoIcons.play_fill, size: 52),
    );
  }

  Widget bottomActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.lock),
        ),
        const Spacer(),
        if (controller.isFullScreen) ...{
          TextButton.icon(
            onPressed: () {},
            label:
                const Text("Episodes", style: TextStyle(color: Colors.white)),
            icon: const Icon(
              CupertinoIcons.list_bullet_below_rectangle,
              color: Colors.white,
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              "Next Episode",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(CupertinoIcons.forward_end, color: Colors.white),
          ),
          const Spacer(),
        },
        IconButton(
          onPressed: toggleVideoFit,
          icon: const Icon(CupertinoIcons.crop),
        ),
        if (!controller.isFullScreen)
          IconButton(
            onPressed: () => controller.enterFullScreen(),
            icon: const Icon(CupertinoIcons.fullscreen),
          )
        else
          IconButton(
            onPressed: () => controller.exitFullScreen(),
            icon: const Icon(CupertinoIcons.fullscreen_exit),
          )
      ],
    );
  }

  bool get _showLoadingIndicator => controller.isVideoInitialized() != true;
}
