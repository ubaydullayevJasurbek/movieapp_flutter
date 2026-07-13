import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

import '../search_cubit/search_movie.dart';
import 'search_movie_card.dart';
import 'search_suggestions.dart';

/// Paginated, pull-to-refresh grid of search results with an autocomplete
/// suggestion header.
class SearchResultsView extends StatefulWidget {
  final List<SearchMovie> movies;
  final List<String> suggestions;
  final bool loadingMore;
  final int crossAxisCount;
  final double childAspectRatio;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final ValueChanged<String> onSuggestionTap;
  final ValueChanged<SearchMovie> onMovieTap;

  const SearchResultsView({
    super.key,
    required this.movies,
    required this.suggestions,
    required this.loadingMore,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onSuggestionTap,
    required this.onMovieTap,
  });

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 400) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: widget.onRefresh,
      child: CustomScrollView(
        controller: _controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (widget.suggestions.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SearchSuggestions(
                  suggestions: widget.suggestions,
                  onTap: widget.onSuggestionTap,
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                childAspectRatio: widget.childAspectRatio,
                crossAxisSpacing: 14,
                mainAxisSpacing: 18,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final movie = widget.movies[index];
                  return SearchMovieCard(
                    key: ValueKey(movie.id),
                    movie: movie,
                    onTap: () => widget.onMovieTap(movie),
                  );
                },
                childCount: widget.movies.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: widget.loadingMore
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: SizedBox(
                          width: 26,
                          height: 26,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(height: 0),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
