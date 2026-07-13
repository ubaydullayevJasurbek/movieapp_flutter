import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/favourite_entity.dart';

/// Isar-backed persistence for favourites. Deals only in [FavouriteEntity];
/// mapping to/from the domain model lives in the repository.
class FavouritesLocalDataSource {
  static late final Isar _isar;

  /// Opens the Isar instance. Call once during app startup.
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([FavouriteEntitySchema], directory: dir.path);
  }

  Future<List<FavouriteEntity>> getAll() =>
      _isar.favouriteEntitys.where().sortByAddedAtDesc().findAll();

  Future<void> add(FavouriteEntity entity) => _isar.writeTxn(
        () => _isar.favouriteEntitys.put(entity),
      );

  Future<void> remove(int movieId) => _isar.writeTxn(
        () => _isar.favouriteEntitys.deleteByMovieId(movieId),
      );
}
