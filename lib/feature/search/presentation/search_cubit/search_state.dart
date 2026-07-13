import 'package:equatable/equatable.dart';

import 'search_movie.dart';

enum SearchStatus { idle, loading, success, empty, error }

/// Immutable snapshot of the search screen.
///
/// A single state object (mirroring the app's `FavouritesState` style) keeps
/// results, recent searches, suggestions and pagination flags in sync and
/// makes rebuilds predictable.
class SearchState extends Equatable {
  final SearchStatus status;
  final String query;
  final List<SearchMovie> movies;
  final List<String> recentSearches;
  final List<String> suggestions;
  final int page;
  final int totalPages;
  final bool loadingMore;
  final String? message;

  const SearchState({
    this.status = SearchStatus.idle,
    this.query = '',
    this.movies = const [],
    this.recentSearches = const [],
    this.suggestions = const [],
    this.page = 1,
    this.totalPages = 1,
    this.loadingMore = false,
    this.message,
  });

  bool get hasReachedMax => page >= totalPages;

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<SearchMovie>? movies,
    List<String>? recentSearches,
    List<String>? suggestions,
    int? page,
    int? totalPages,
    bool? loadingMore,
    String? message,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      movies: movies ?? this.movies,
      recentSearches: recentSearches ?? this.recentSearches,
      suggestions: suggestions ?? this.suggestions,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      loadingMore: loadingMore ?? this.loadingMore,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        query,
        movies,
        recentSearches,
        suggestions,
        page,
        totalPages,
        loadingMore,
        message,
      ];
}
