import 'package:betterplayer_demo/bloc/media_player_bloc.dart';
import 'package:betterplayer_demo/bloc/playlist_bloc.dart';
import 'package:betterplayer_demo/presentation/widgets/playlist/media_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key}) : _grid = false;

  const PlaylistView.grid({super.key}) : _grid = true;

  final bool _grid;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final playlistState = context.watch<PlaylistBloc>().state;
      final mediaPlayerState = context.watch<MediaPlayerBloc>().state;

      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
        ),
        itemCount: playlistState.playlist.length,
        itemBuilder: (context, index) => MediaItemView(
          playlistState.playlist[index],
          selected: mediaPlayerState.current == playlistState.playlist[index],
        ),
      );
    });
  }
}
