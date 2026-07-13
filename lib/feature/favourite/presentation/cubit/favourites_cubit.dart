import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/favourite_movie.dart';
import '../../domain/usecases/add_favourite.dart';
import '../../domain/usecases/get_favourites.dart';
import '../../domain/usecases/remove_favourite.dart';

enum FavouritesStatus { loading, loaded, error }

class FavouritesState {
  final FavouritesStatus status;
  final List<FavouriteMovie> favourites;
  final String? message;

  const FavouritesState({
    required this.status,
    this.favourites = const [],
    this.message,
  });

  const FavouritesState.loading()
      : status = FavouritesStatus.loading,
        favourites = const [],
        message = null;
}

/// App-wide singleton so the details screen (writer) and the favourites
/// screen (reader) share the same in-memory source of truth.
///
/// Dependencies are injected via the constructor; the singleton is assembled
/// once in the composition root (see `setupFavourites` in
/// `favourite_injection.dart`).
class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required GetFavourites getFavourites,
    required AddFavourite addFavourite,
    required RemoveFavourite removeFavourite,
  })  : _getFavourites = getFavourites,
        _addFavourite = addFavourite,
        _removeFavourite = removeFavourite,
        super(const FavouritesState.loading()) {
    load();
  }

  /// Assigned once by the composition root during app startup.
  static late final FavouritesCubit instance;

  final GetFavourites _getFavourites;
  final AddFavourite _addFavourite;
  final RemoveFavourite _removeFavourite;

  final List<FavouriteMovie> _items = [];

  Future<void> load() async {
    emit(const FavouritesState.loading());
    try {
      final items = await _getFavourites();
      _items
        ..clear()
        ..addAll(items);
      _emitLoaded();
    } catch (e) {
      emit(FavouritesState(status: FavouritesStatus.error, message: e.toString()));
    }
  }

  bool contains(int id) => _items.any((e) => e.id == id);

  Future<void> toggle(FavouriteMovie movie) async {
    if (contains(movie.id)) {
      _items.removeWhere((e) => e.id == movie.id);
      await _removeFavourite(movie.id);
    } else {
      _items.insert(0, movie);
      await _addFavourite(movie);
    }
    _emitLoaded();
  }

  Future<void> remove(int id) async {
    _items.removeWhere((e) => e.id == id);
    await _removeFavourite(id);
    _emitLoaded();
  }

  void _emitLoaded() {
    emit(FavouritesState(
      status: FavouritesStatus.loaded,
      favourites: List.unmodifiable(_items),
    ));
  }
}
