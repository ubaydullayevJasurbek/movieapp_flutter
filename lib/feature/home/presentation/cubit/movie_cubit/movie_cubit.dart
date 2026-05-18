import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository_impl/movie_repository.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _repository = MovieRepository();

  MovieCubit() : super(MovieInitial());

  Future<void> getMovies() async {
    emit(MovieLoading());
    try {
      final response = await _repository.getMovies();
      emit(MovieLoaded(response.results));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }


}