import '../entities/favourite_movie.dart';
import '../repository/favourites_repository.dart';

/// Loads all saved favourites, newest first.
class GetFavourites {
  final FavouritesRepository _repository;

  const GetFavourites(this._repository);

  Future<List<FavouriteMovie>> call() => _repository.getAll();
}
