import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';

/// Lightweight model persisted in the favourites store.
class FavouriteMovie {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final DateTime? releaseDate;
  final List<String> genres;
  final String mediaType; // 'movie' | 'tv'
  final DateTime addedAt;

  const FavouriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
    required this.mediaType,
    required this.addedAt,
  });

  factory FavouriteMovie.fromDetail(MovieDetail movie) => FavouriteMovie(
    id: movie.id,
    title: movie.title,
    posterPath: movie.posterPath,
    voteAverage: movie.voteAverage,
    releaseDate: movie.releaseDate,
    genres: movie.genres,
    mediaType: 'movie',
    addedAt: DateTime.now(),
  );

  bool get isTv => mediaType == 'tv';

  String? get posterUrl => (posterPath == null || posterPath!.isEmpty)
      ? null
      : "https://image.tmdb.org/t/p/w500$posterPath";

  String get year =>
      releaseDate != null ? releaseDate!.year.toString() : '—';
}
