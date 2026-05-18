import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository_impl/movie_repository.dart';
import 'now_playing_state.dart';


class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MovieRepository _repository = MovieRepository();

  NowPlayingCubit() : super(NowPlayingInitial());

  Future<void> getNowPlaying() async {
    emit(NowPlayingLoading());
    try {
      final nowResponse = await _repository.getNowPlay();
      emit(NowPlayingLoaded(nowResponse.results));
    } catch (e) {
      emit(NowPlayingError(e.toString()));
    }
  }
}
