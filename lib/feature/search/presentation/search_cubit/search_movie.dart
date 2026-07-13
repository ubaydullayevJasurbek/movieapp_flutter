import 'package:movieapp/core/constants/movie_genres.dart';

import '../../data/models/search_response/search_response.dart';

/// Lightweight, UI-facing movie model derived from a search API [Result].
///
/// Keeps the presentation layer decoupled from the raw TMDB response shape and
/// resolves genre ids to display names once, up front.
class SearchMovie {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final DateTime? releaseDateTime;
  final List<String> genres;

  const SearchMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDateTime,
    required this.genres,
  });

  factory SearchMovie.fromResult(Result result) {
    final poster = result.posterPath;
    return SearchMovie(
      id: result.id,
      title: result.title,
      posterPath: (poster == null || poster.isEmpty) ? null : poster,
      voteAverage: result.voteAverage,
      releaseDateTime: DateTime.tryParse(result.releaseDate),
      genres: MovieGenres.namesFor(result.genreIds),
    );
  }

  String? get posterUrl {
    final path = posterPath;
    if (path == null) return null;
    return 'https://image.tmdb.org/t/p/w500$path';
  }

  String? get year => releaseDateTime?.year.toString();

  String get ratingText => voteAverage.toStringAsFixed(1);
}
