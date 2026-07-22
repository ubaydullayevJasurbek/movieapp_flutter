import 'package:json_annotation/json_annotation.dart';
part 'now_playing_response.g.dart';


@JsonSerializable()
class NowPlayingResponse {
  @JsonKey(name: "dates")
  final Dates dates;
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "results")
  final List<Result> results;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;

  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlayingResponse.fromJson(Map<String, dynamic> json) => _$NowPlayingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NowPlayingResponseToJson(this);
}

@JsonSerializable()
class Dates {
  @JsonKey(name: "maximum")
  final DateTime maximum;
  @JsonKey(name: "minimum")
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "adult")
  final bool adult;
  @JsonKey(name: "backdrop_path")
  final String backdropPath;
  @JsonKey(name: "genre_ids")
  final List<int> genreIds;
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "original_language")
  final String originalLanguage;
  @JsonKey(name: "original_title")
  final String originalTitle;
  @JsonKey(name: "overview")
  final String overview;
  @JsonKey(name: "popularity")
  final double popularity;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "release_date")
  final DateTime releaseDate;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "video")
  final bool video;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "vote_count")
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  factory Result.fake({int id = 0}) => Result(
        adult: false,
        backdropPath: '',
        genreIds: const [],
        id: id,
        originalLanguage: 'en',
        originalTitle: '',
        overview: '',
        popularity: 0,
        posterPath: '/$id',
        releaseDate: DateTime(2024, 1, 1),
        title: 'Movie title',
        video: false,
        voteAverage: 8.5,
        voteCount: 0,
      );

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

const genreMap = {
  28: 'Action', 12: 'Adventure', 16: 'Animation',
  35: 'Comedy', 80: 'Crime', 99: 'Documentary',
  18: 'Drama', 10751: 'Family', 14: 'Fantasy',
  36: 'History', 27: 'Horror', 10402: 'Music',
  9648: 'Mystery', 10749: 'Romance', 878: 'Sci-Fi',
  10770: 'TV Movie', 53: 'Thriller', 10752: 'War', 37: 'Western',
};
