import '../../domain/entities/favourite_movie.dart';
import '../models/favourite_entity.dart';

/// Converts between the Isar persistence model and the domain entity.
extension FavouriteEntityMapper on FavouriteEntity {
  FavouriteMovie toModel() => FavouriteMovie(
        id: movieId,
        title: title,
        posterPath: posterPath,
        voteAverage: voteAverage,
        releaseDate: releaseDate,
        genres: genres,
        mediaType: mediaType,
        addedAt: addedAt,
      );
}

extension FavouriteMovieMapper on FavouriteMovie {
  FavouriteEntity toEntity() => FavouriteEntity()
    ..movieId = id
    ..title = title
    ..posterPath = posterPath
    ..voteAverage = voteAverage
    ..releaseDate = releaseDate
    ..genres = genres
    ..mediaType = mediaType
    ..addedAt = addedAt;
}
