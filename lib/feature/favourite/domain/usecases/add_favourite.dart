import '../entities/favourite_movie.dart';
import '../repository/favourites_repository.dart';

/// Persists a movie to the favourites store.
class AddFavourite {
  final FavouritesRepository _repository;

  const AddFavourite(this._repository);

  Future<void> call(FavouriteMovie movie) => _repository.add(movie);
}
