// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TVSeriesResponse _$TvSeriesResponseFromJson(Map<String, dynamic> json) =>
    TVSeriesResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$TvSeriesResponseToJson(TVSeriesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  backdropPath: json['backdrop_path'] as String,
  firstAirDate: DateTime.parse(json['first_air_date'] as String),
  genreIds: (json['genre_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  originCountry: (json['origin_country'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  originalLanguage: json['original_language'] as String,
  originalName: json['original_name'] as String,
  overview: json['overview'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  posterPath: json['poster_path'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'backdrop_path': instance.backdropPath,
  'first_air_date': instance.firstAirDate.toIso8601String(),
  'genre_ids': instance.genreIds,
  'id': instance.id,
  'name': instance.name,
  'origin_country': instance.originCountry,
  'original_language': instance.originalLanguage,
  'original_name': instance.originalName,
  'overview': instance.overview,
  'popularity': instance.popularity,
  'poster_path': instance.posterPath,
  'vote_average': instance.voteAverage,
  'vote_count': instance.voteCount,
};
