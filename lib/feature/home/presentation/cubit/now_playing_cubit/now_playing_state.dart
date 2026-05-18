
import '../../../data/model/now_playing_response/now_playing_response.dart';

sealed class NowPlayingState {}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState{}

class NowPlayingLoaded extends NowPlayingState{
  final List<Result> movies;

  NowPlayingLoaded(this.movies);
}

class NowPlayingError extends NowPlayingState{
  final String message;

  NowPlayingError(this.message);
}


