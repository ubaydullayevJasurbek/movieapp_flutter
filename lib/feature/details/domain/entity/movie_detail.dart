import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final DateTime releaseDate;
  final int runtime;
  final List<String> genres;
  final String status;
  final String? tagline;
  final double popularity;
  final int budget;
  final int revenue;
  final String originalLanguage;
  final String originalTitle;
  final bool adult;
  final bool video;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    required this.status,
    this.tagline,
    required this.popularity,
    required this.budget,
    required this.revenue,
    required this.originalLanguage,
    required this.originalTitle,
    required this.adult,
    required this.video,
  });

  @override
  List<Object?> get props => [
    id, title, overview, posterPath, backdropPath,
    voteAverage, voteCount, releaseDate, runtime, genres,
    status, tagline, popularity, budget, revenue,
    originalLanguage, originalTitle, adult, video,
  ];
}