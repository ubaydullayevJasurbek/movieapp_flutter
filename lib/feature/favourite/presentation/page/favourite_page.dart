import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import '../../domain/entities/favourite_movie.dart';
import '../../domain/entities/favourite_query.dart';
import '../../domain/usecases/filter_favourites.dart';
import '../cubit/favourites_cubit.dart';
import '../widget/cards/favourite_grid_view.dart';
import '../widget/cards/favourite_list_view.dart';
import '../widget/dialogs/remove_favourite_dialog.dart';
import '../widget/filter/favourites_filter_bar.dart';
import '../widget/header/favourites_header.dart';
import '../widget/search/favourites_search_field.dart';
import '../widget/states/favourites_empty_state.dart';
import '../widget/states/favourites_error_state.dart';
import '../widget/states/favourites_loading_state.dart';
import '../widget/states/favourites_no_matches_state.dart';
import '../widget/toolbar/favourites_toolbar.dart';

const _kBg = AppColors.background;
const _kAccent = AppColors.primary;

class FavouritePage extends StatefulWidget {
  /// Called by the empty-state CTA to send the user to the Home tab.
  final VoidCallback? onBrowse;

  const FavouritePage({super.key, this.onBrowse});

  @override
  State<FavouritePage> createState() => _FavouriteState();
}

class _FavouriteState extends State<FavouritePage> {
  final _searchController = TextEditingController();
  final _filterFavourites = const FilterFavourites();

  String _query = '';
  FavouriteFilter _filter = FavouriteFilter.all;
  FavouriteSort _sort = FavouriteSort.recent;
  bool _grid = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _remove(FavouriteMovie movie) {
    FavouritesCubit.instance.remove(movie.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surface,
          content: Text('Removed "${movie.title}"',
              style: const TextStyle(color: Colors.white)),
          action: SnackBarAction(
            label: 'Undo',
            textColor: _kAccent,
            onPressed: () => FavouritesCubit.instance.toggle(movie),
          ),
        ),
      );
  }

  Future<void> _handleRemove(FavouriteMovie movie) async {
    if (await showRemoveFavouriteDialog(context, movie)) _remove(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<FavouritesCubit, FavouritesState>(
          bloc: FavouritesCubit.instance,
          builder: (context, state) {
            final total = state.favourites.length;
            final visible = _filterFavourites(
              state.favourites,
              filter: _filter,
              query: _query,
              sort: _sort,
            );

            return Column(
              children: [
                FavouritesHeader(count: total),
                if (state.status == FavouritesStatus.loaded && total > 0) ...[
                  FavouritesSearchField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _query = v),
                  ),
                  FavouritesFilterBar(
                    filter: _filter,
                    onChanged: (f) => setState(() => _filter = f),
                  ),
                  FavouritesToolbar(
                    count: visible.length,
                    sort: _sort,
                    grid: _grid,
                    onSort: (s) => setState(() => _sort = s),
                    onToggleView: () => setState(() => _grid = !_grid),
                  ),
                ],
                Expanded(child: _buildBody(state, visible)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(FavouritesState state, List<FavouriteMovie> visible) {
    if (state.status == FavouritesStatus.loading) {
      return const FavouritesLoadingState();
    }
    if (state.status == FavouritesStatus.error) {
      return FavouritesErrorState(
        message: state.message,
        onRetry: () => FavouritesCubit.instance.load(),
      );
    }
    if (state.favourites.isEmpty) {
      return FavouritesEmptyState(onBrowse: widget.onBrowse);
    }
    if (visible.isEmpty) {
      return const FavouritesNoMatchesState();
    }

    return RefreshIndicator(
      color: _kAccent,
      backgroundColor: AppColors.surface,
      onRefresh: () => FavouritesCubit.instance.load(),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _grid
            ? FavouriteGridView(
                key: const ValueKey('grid'),
                movies: visible,
                onRemove: _handleRemove,
              )
            : FavouriteListView(
                key: const ValueKey('list'),
                movies: visible,
                onRemove: _handleRemove,
                confirmRemove: (movie) => showRemoveFavouriteDialog(context, movie),
                onRemoved: _remove,
              ),
      ),
    );
  }
}
