import 'data/datasource/favourites_local_data_source.dart';
import 'data/repository/favourites_repository_impl.dart';
import 'domain/repository/favourites_repository.dart';
import 'domain/usecases/add_favourite.dart';
import 'domain/usecases/get_favourites.dart';
import 'domain/usecases/remove_favourite.dart';
import 'presentation/cubit/favourites_cubit.dart';

/// Composition root for the Favourite feature.
///
/// Opens local storage and wires datasource → repository → use cases → cubit,
/// then assigns the shared [FavouritesCubit.instance]. Call once during app
/// startup, before `runApp`.
Future<void> setupFavourites() async {
  await FavouritesLocalDataSource.init();

  final FavouritesRepository repository =
      FavouritesRepositoryImpl(FavouritesLocalDataSource());

  FavouritesCubit.instance = FavouritesCubit(
    getFavourites: GetFavourites(repository),
    addFavourite: AddFavourite(repository),
    removeFavourite: RemoveFavourite(repository),
  );
}
