import '../repository/favourites_repository.dart';

/// Removes a movie from the favourites store by its id.
class RemoveFavourite {
  final FavouritesRepository _repository;

  const RemoveFavourite(this._repository);

  Future<void> call(int movieId) => _repository.remove(movieId);
}
