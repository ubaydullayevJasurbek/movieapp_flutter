import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/feature/home/data/data_source/recent_searches_local_data_source.dart';
import 'package:movieapp/feature/home/data/repository_impl/movie_repository.dart';

import 'search_movie.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    MovieRepository? repository,
    RecentSearchesLocalDataSource? recentSearches,
  })  : _repository = repository ?? MovieRepository(),
        _recentSearches = recentSearches ?? RecentSearchesLocalDataSource(),
        super(const SearchState());

  final MovieRepository _repository;
  final RecentSearchesLocalDataSource _recentSearches;

  static const Duration _debounce = Duration(milliseconds: 300);
  static const int _maxSuggestions = 6;

  Timer? _debounceTimer;
  int _requestId = 0;

  Future<void> loadRecentSearches() async {
    final items = await _recentSearches.getAll();
    emit(state.copyWith(recentSearches: items));
  }

  /// Real-time search entry point. Debounces keystrokes and clears results
  /// as soon as the query becomes empty.
  void onQueryChanged(String rawQuery) {
    final query = rawQuery.trim();
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      _requestId++;
      emit(state.copyWith(
        status: SearchStatus.idle,
        query: '',
        movies: const [],
        suggestions: const [],
        page: 1,
        totalPages: 1,
        loadingMore: false,
      ));
      return;
    }

    emit(state.copyWith(query: query));
    _debounceTimer = Timer(_debounce, () => _search(query));
  }

  /// Runs a search immediately, bypassing the debounce (chips, retry, submit).
  void submitQuery(String rawQuery) {
    final query = rawQuery.trim();
    if (query.isEmpty) return;
    _debounceTimer?.cancel();
    emit(state.copyWith(query: query));
    _search(query, persist: true);
  }

  Future<void> refresh() async {
    if (state.query.isEmpty) return;
    await _search(state.query, persist: false);
  }

  Future<void> _search(String query, {bool persist = false}) async {
    final requestId = ++_requestId;
    emit(state.copyWith(status: SearchStatus.loading, query: query));

    try {
      final response = await _repository.getSearch(query, page: 1);
      if (requestId != _requestId) return;

      final movies =
          response.results.map(SearchMovie.fromResult).toList(growable: false);

      emit(state.copyWith(
        status: movies.isEmpty ? SearchStatus.empty : SearchStatus.success,
        movies: movies,
        suggestions: _suggestionsFrom(movies),
        page: response.page,
        totalPages: response.totalPages,
        loadingMore: false,
      ));

      if (persist) await _remember(query);
    } catch (e) {
      if (requestId != _requestId) return;
      emit(state.copyWith(status: SearchStatus.error, message: _readable(e)));
    }
  }

  Future<void> loadMore() async {
    if (state.status != SearchStatus.success ||
        state.loadingMore ||
        state.hasReachedMax) {
      return;
    }

    final requestId = _requestId;
    emit(state.copyWith(loadingMore: true));

    try {
      final nextPage = state.page + 1;
      final response = await _repository.getSearch(state.query, page: nextPage);
      if (requestId != _requestId) return;

      final more = response.results.map(SearchMovie.fromResult);

      emit(state.copyWith(
        movies: _mergeUnique(state.movies, more),
        page: response.page,
        totalPages: response.totalPages,
        loadingMore: false,
      ));
    } catch (_) {
      if (requestId != _requestId) return;
      emit(state.copyWith(loadingMore: false));
    }
  }

  /// Persists a search term the moment the user commits to a result.
  Future<void> rememberQuery(String query) => _remember(query);

  Future<void> _remember(String query) async {
    final items = await _recentSearches.add(query);
    emit(state.copyWith(recentSearches: items));
  }

  Future<void> removeRecentSearch(String term) async {
    final items = await _recentSearches.remove(term);
    emit(state.copyWith(recentSearches: items));
  }

  Future<void> clearRecentSearches() async {
    await _recentSearches.clear();
    emit(state.copyWith(recentSearches: const []));
  }

  List<SearchMovie> _mergeUnique(
    List<SearchMovie> current,
    Iterable<SearchMovie> incoming,
  ) {
    final seen = current.map((m) => m.id).toSet();
    final merged = List<SearchMovie>.from(current);
    for (final movie in incoming) {
      if (seen.add(movie.id)) merged.add(movie);
    }
    return merged;
  }

  List<String> _suggestionsFrom(List<SearchMovie> movies) => movies
      .map((m) => m.title)
      .where((t) => t.trim().isNotEmpty)
      .toSet()
      .take(_maxSuggestions)
      .toList(growable: false);

  String _readable(Object error) =>
      error.toString().replaceFirst('Exception: ', '');

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
