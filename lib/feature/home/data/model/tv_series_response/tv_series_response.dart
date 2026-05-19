import 'package:json_annotation/json_annotation.dart';
part 'tv_series_response.g.dart';

@JsonSerializable()
class TVSeriesResponse {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "results")
  final List<Result> results;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;

  TVSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) => _$TvSeriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TvSeriesResponseToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "backdrop_path")
  final String backdropPath;
  @JsonKey(name: "first_air_date")
  final DateTime firstAirDate;
  @JsonKey(name: "genre_ids")
  final List<int> genreIds;
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "origin_country")
  final List<String> originCountry;
  @JsonKey(name: "original_language")
  final String originalLanguage;
  @JsonKey(name: "original_name")
  final String originalName;
  @JsonKey(name: "overview")
  final String overview;
  @JsonKey(name: "popularity")
  final double popularity;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "vote_count")
  final int voteCount;

  Result({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
