import 'package:betterplayer_demo/bloc/media_player_bloc.dart';
import 'package:betterplayer_demo/bloc/playlist_bloc.dart';
import 'package:betterplayer_demo/models/media.dart';
import 'package:betterplayer_demo/presentation/widgets/playlist/media_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key}) : _grid = false;

  const PlaylistView.grid({super.key}) : _grid = true;

  final bool _grid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) => ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
        ),
        itemCount: state.playlist.length,
        itemBuilder: (context, index) => MediaItemView(
          state.playlist[index],
          // selected: _isSelected(context, state.playlist[index]),
        ),
      ),
    );
  }

  bool _isSelected(BuildContext context, Media media) =>
      context.select<MediaPlayerBloc, Media?>((v) => v.state.current) == media;
}
