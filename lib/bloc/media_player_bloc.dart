import 'package:betterplayer_demo/models/media.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaPlayerBloc extends Bloc<MediaPlayerEvent, MediaPlayerState> {
  MediaPlayerBloc() : super(const MediaPlayerState()) {
    on<Play>((event, Emitter<MediaPlayerState> emit) async =>
        emit(MediaPlayerState(current: event.media)));
  }
}

class MediaPlayerState {
  final Media? current;

  bool get hasMedia => current != null;

  const MediaPlayerState({this.current});
}

abstract class MediaPlayerEvent {
  const MediaPlayerEvent();
}

class Play extends MediaPlayerEvent {
  final Media media;

  const Play({required this.media});
}

// class ShowAds extends MediaPlayerEvent{
//
// }