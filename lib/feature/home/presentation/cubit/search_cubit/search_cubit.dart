import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/feature/home/data/repository_impl/movie_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieRepository _repository = MovieRepository();

  SearchCubit() : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      final response = await _repository.getSearch(query);
      emit(SearchLoaded(response.results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}