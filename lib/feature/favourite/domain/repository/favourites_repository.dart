import '../entities/favourite_movie.dart';

/// Contract for reading and mutating the favourites store.
abstract class FavouritesRepository {
  Future<List<FavouriteMovie>> getAll();

  Future<void> add(FavouriteMovie movie);

  Future<void> remove(int movieId);
}
