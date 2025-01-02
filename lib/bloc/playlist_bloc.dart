import 'package:betterplayer_demo/models/media.dart';
import 'package:betterplayer_demo/repository/media_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final MediaRepo mediaRepo = MediaRepo();

  PlaylistBloc() : super(const PlaylistState()) {
    on<Load>((event, Emitter<PlaylistState> emit) async {
      try {
        emit(LoadingPlaylist());
        final playlist = await mediaRepo.getPlaylist();
        emit(PlaylistState(playlist: playlist));
      } catch (err) {
        emit(PlaylistError(err));
      }
    });

    add(const Load());
  }
}

class PlaylistState {
  final List<Media> playlist;

  const PlaylistState({this.playlist = const []});
}

class LoadingPlaylist extends PlaylistState {}

class PlaylistError extends PlaylistState {
  final Object err;

  PlaylistError(this.err);
}

abstract class PlaylistEvent {
  const PlaylistEvent();
}

class Load extends PlaylistEvent {
  // final Content content; (Movie,Series,LiveTV,Whatever)
  const Load();
}
