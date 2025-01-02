import 'package:betterplayer_demo/bloc/media_player_bloc.dart';
import 'package:betterplayer_demo/models/media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaItemView extends StatelessWidget {
  final Media media;
  final bool selected;

  const MediaItemView(
    this.media, {
    super.key,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      title: Text(media.title),
      subtitle: Text(media.url),
      trailing: _indicators(media),
      onTap: () => context.read<MediaPlayerBloc>().add(Play(media: media)),
    );
  }

  Widget? _indicators(Media media) {
    if (media.type == MediaType.live) {
      return const Chip(
        label: Text("LIVE", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      );
    }

    return null;
  }
}
