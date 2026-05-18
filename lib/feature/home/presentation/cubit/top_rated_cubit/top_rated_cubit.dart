import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/feature/home/data/repository_impl/movie_repository.dart';
import 'package:movieapp/feature/home/presentation/cubit/top_rated_cubit/top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final MovieRepository _repository = MovieRepository();

  TopRatedCubit() : super(TopRatedInitial());

  Future<void> getTopRated() async {
    emit(TopRatedLoading());
    try {
      final response = await _repository.getTopRated();
      emit(TopRatedLoaded(response.results));
    } catch (e) {
      emit(TopRatedError(e.toString()));
    }
  }
}
