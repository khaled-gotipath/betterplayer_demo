import 'package:betterplayer_demo/bloc/media_player_bloc.dart';
import 'package:betterplayer_demo/bloc/playlist_bloc.dart';
import 'package:betterplayer_demo/presentation/widgets/media_player/media_player.dart';
import 'package:betterplayer_demo/presentation/widgets/playlist/playlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final GlobalKey<RefreshIndicatorState> _refresher = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PlaylistBloc()),
          BlocProvider(create: (_) => MediaPlayerBloc()),
        ],
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const MediaPlayer(),
              // if (nowPlaying == null)
              //   const Card.outlined(
              //     child: Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text("Please select a media below to play"),
              //     ),
              //   ),
              BlocBuilder<PlaylistBloc, PlaylistState>(
                builder: (context, state) => Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const PlaylistView(),
                      if (state.runtimeType == LoadingPlaylist)
                        const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
