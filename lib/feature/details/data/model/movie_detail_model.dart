import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';

import 'details_response/details_response.dart';

extension DetailsResponseMapper on DetailsResponse {
  MovieDetail toEntity() => MovieDetail(
    id: id,
    title: title,
    overview: overview,
    posterPath: posterPath,
    backdropPath: backdropPath,
    voteAverage: voteAverage,
    voteCount: voteCount,
    releaseDate: releaseDate,
    runtime: runtime,
    genres: genres.map((g) => g.name).toList(),
    status: status,
    tagline: tagline,
    popularity: popularity,
    budget: budget,
    revenue: revenue,
    originalLanguage: originalLanguage,
    originalTitle: originalTitle,
    adult: adult,
    video: video,
  );
}