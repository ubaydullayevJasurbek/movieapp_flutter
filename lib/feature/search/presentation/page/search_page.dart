import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/core/theme/theme_cubit.dart';
import 'package:movieapp/feature/details/presentation/pages/movie_details_page.dart';

import '../search/search_app_bar.dart';
import '../search/search_idle_view.dart';
import '../search/search_loading_shimmer.dart';
import '../search/search_results_view.dart';
import '../search/search_status_view.dart';
import '../search_cubit/search_cubit.dart';
import '../search_cubit/search_movie.dart';
import '../search_cubit/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    this.onBack,
    this.focusNode,
    this.onRegisterBack,
  });

  /// Invoked when the in-page back button is tapped. When the page lives inside
  /// the [MainPage] bottom navigation this switches back to the Home tab; when
  /// it is pushed as a route it falls back to popping.
  final VoidCallback? onBack;

  /// Optional externally-owned focus node. [MainPage] passes one so the Home
  /// search shortcut can focus this field when switching tabs. When null the
  /// page creates and owns its own node.
  final FocusNode? focusNode;

  /// Lets [MainPage]'s central Android-back handler ask this page to step back
  /// within its own hierarchy (genre / results subpage → search root). The
  /// registered callback returns true when it consumed the back.
  final ValueChanged<bool Function()?>? onRegisterBack;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit()..loadRecentSearches(),
      child: _SearchView(
        onBack: onBack,
        focusNode: focusNode,
        onRegisterBack: onRegisterBack,
      ),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView({this.onBack, this.focusNode, this.onRegisterBack});

  final VoidCallback? onBack;
  final FocusNode? focusNode;
  final ValueChanged<bool Function()?>? onRegisterBack;

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _controller = TextEditingController();

  /// Use the node supplied by [MainPage] when present; otherwise own one.
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  bool get _ownsFocusNode => widget.focusNode == null;

  @override
  void initState() {
    super.initState();
    widget.onRegisterBack?.call(_handleInternalBack);
  }

  @override
  void dispose() {
    widget.onRegisterBack?.call(null);
    _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  /// Steps back one level inside the Search hierarchy. When a subpage (genre or
  /// search results / loading / empty / error) is showing, it returns to the
  /// search root (recent, trending, genres) and reports that it handled the
  /// back. On the root itself it returns false so [MainPage] can leave the tab.
  bool _handleInternalBack() {
    if (_cubit.state.status == SearchStatus.idle) return false;
    _controller.clear();
    _cubit.onQueryChanged('');
    _focusNode.unfocus();
    return true;
  }

  /// The in-page back arrow mirrors the Android back gesture: step back to the
  /// search root first, otherwise leave the page (Home tab, or pop if pushed).
  void _onBackPressed() {
    if (_handleInternalBack()) return;
    (widget.onBack ?? () => Navigator.pop(context))();
  }

  SearchCubit get _cubit => context.read<SearchCubit>();

  void _applyQuery(String term) {
    _controller
      ..text = term
      ..selection = TextSelection.collapsed(offset: term.length);
    _focusNode.unfocus();
    _cubit.submitQuery(term);
  }

  void _clear() {
    _controller.clear();
    _cubit.onQueryChanged('');
    _focusNode.requestFocus();
  }

  void _openMovie(SearchMovie movie) {
    _cubit.rememberQuery(_cubit.state.query);
    _focusNode.unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MovieDetailsPage(movieId: movie.id)),
    );
  }

  ({int crossAxisCount, double childAspectRatio}) _gridMetrics(double width) {
    if (width >= 900) return (crossAxisCount: 4, childAspectRatio: 0.56);
    if (width >= 600) return (crossAxisCount: 3, childAspectRatio: 0.56);
    return (crossAxisCount: 2, childAspectRatio: 0.54);
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild in place on theme changes so the AppColors tokens re-resolve.
    context.watch<ThemeCubit>();

    final width = MediaQuery.sizeOf(context).width;
    final grid = _gridMetrics(width);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              SearchAppBar(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: _cubit.onQueryChanged,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) _applyQuery(value);
                },
                onClear: _clear,
                onBack: _onBackPressed,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: _buildBody(state, grid),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    SearchState state,
    ({int crossAxisCount, double childAspectRatio}) grid,
  ) {
    switch (state.status) {
      case SearchStatus.loading:
        return SearchLoadingShimmer(
          key: const ValueKey('loading'),
          crossAxisCount: grid.crossAxisCount,
          childAspectRatio: grid.childAspectRatio,
        );
      case SearchStatus.error:
        return SearchErrorView(
          key: const ValueKey('error'),
          message: state.message ?? 'Please try again.',
          onRetry: () => _cubit.submitQuery(state.query),
        );
      case SearchStatus.empty:
        return SearchEmptyView(
          key: const ValueKey('empty'),
          query: state.query,
        );
      case SearchStatus.success:
        return SearchResultsView(
          key: const ValueKey('results'),
          movies: state.movies,
          suggestions: state.suggestions,
          loadingMore: state.loadingMore,
          crossAxisCount: grid.crossAxisCount,
          childAspectRatio: grid.childAspectRatio,
          onRefresh: _cubit.refresh,
          onLoadMore: _cubit.loadMore,
          onSuggestionTap: _applyQuery,
          onMovieTap: _openMovie,
        );
      case SearchStatus.idle:
        return SearchIdleView(
          key: const ValueKey('idle'),
          recentSearches: state.recentSearches,
          onTermTap: _applyQuery,
          onRecentDelete: _cubit.removeRecentSearch,
          onClearRecent: _cubit.clearRecentSearches,
        );
    }
  }
}
