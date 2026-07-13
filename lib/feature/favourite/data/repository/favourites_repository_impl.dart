import '../../domain/entities/favourite_movie.dart';
import '../../domain/repository/favourites_repository.dart';
import '../datasource/favourites_local_data_source.dart';
import '../mapper/favourite_mapper.dart';

/// Local-only implementation backed by [FavouritesLocalDataSource].
class FavouritesRepositoryImpl implements FavouritesRepository {
  final FavouritesLocalDataSource _local;

  const FavouritesRepositoryImpl(this._local);

  @override
  Future<List<FavouriteMovie>> getAll() async {
    final entities = await _local.getAll();
    return entities.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> add(FavouriteMovie movie) => _local.add(movie.toEntity());

  @override
  Future<void> remove(int movieId) => _local.remove(movieId);
}
