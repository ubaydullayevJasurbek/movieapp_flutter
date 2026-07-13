import '../entities/favourite_movie.dart';
import '../entities/favourite_query.dart';

/// Applies the active search query, media-type filter and sort order to the
/// favourites list. Pure logic — no side effects.
class FilterFavourites {
  const FilterFavourites();

  List<FavouriteMovie> call(
    List<FavouriteMovie> source, {
    required FavouriteFilter filter,
    required String query,
    required FavouriteSort sort,
  }) {
    final q = query.trim().toLowerCase();
    final list = source.where((m) {
      final matchesFilter = switch (filter) {
        FavouriteFilter.all => true,
        FavouriteFilter.movies => !m.isTv,
        FavouriteFilter.tv => m.isTv,
      };
      final matchesQuery = q.isEmpty || m.title.toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();

    list.sort((a, b) => switch (sort) {
          FavouriteSort.recent => b.addedAt.compareTo(a.addedAt),
          FavouriteSort.rating => b.voteAverage.compareTo(a.voteAverage),
          FavouriteSort.release => (b.releaseDate ?? DateTime(1900))
              .compareTo(a.releaseDate ?? DateTime(1900)),
          FavouriteSort.az => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        });
    return list;
  }
}
