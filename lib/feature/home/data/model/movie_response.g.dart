// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      dates: Dates.fromJson(json['dates'] as Map<String, dynamic>),
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Dates _$DatesFromJson(Map<String, dynamic> json) => Dates(
  maximum: DateTime.parse(json['maximum'] as String),
  minimum: DateTime.parse(json['minimum'] as String),
);

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
  'maximum': instance.maximum.toIso8601String(),
  'minimum': instance.minimum.toIso8601String(),
};

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  adult: json['adult'] as bool,
  backdropPath: json['backdrop_path'] as String,
  genreIds: (json['genre_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  id: (json['id'] as num).toInt(),
  originalLanguage: json['original_language'] as String,
  originalTitle: json['original_title'] as String,
  overview: json['overview'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  posterPath: json['poster_path'] as String,
  releaseDate: DateTime.parse(json['release_date'] as String),
  title: json['title'] as String,
  video: json['video'] as bool,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'adult': instance.adult,
  'backdrop_path': instance.backdropPath,
  'genre_ids': instance.genreIds,
  'id': instance.id,
  'original_language': instance.originalLanguage,
  'original_title': instance.originalTitle,
  'overview': instance.overview,
  'popularity': instance.popularity,
  'poster_path': instance.posterPath,
  'release_date': instance.releaseDate.toIso8601String(),
  'title': instance.title,
  'video': instance.video,
  'vote_average': instance.voteAverage,
  'vote_count': instance.voteCount,
};
