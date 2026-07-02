// lib/feature/home/data/model/movie_detail_response/movie_detail_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_response.g.dart';

@JsonSerializable()
class MovieDetailResponse {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "overview")
  final String overview;
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;
  @JsonKey(name: "release_date")
  final String releaseDate;
  @JsonKey(name: "runtime")
  final int? runtime;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "genres")
  final List<Genre> genres;

  MovieDetailResponse({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.genres,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailResponseToJson(this);

  /// "2h 18m" ko'rinishidagi runtime
  String get runtimeLabel {
    if (runtime == null || runtime == 0) return '';
    final h = runtime! ~/ 60;
    final m = runtime! % 60;
    return '${h}h ${m}m';
  }
}

@JsonSerializable()
class Genre {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}