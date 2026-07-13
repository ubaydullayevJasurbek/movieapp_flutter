import 'package:flutter/material.dart';

import 'genre_grid_section.dart';
import 'recent_searches_section.dart';
import 'trending_searches_section.dart';

/// Content shown before the user searches: recent terms, trending terms and
/// the browsable genre grid.
class SearchIdleView extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<String> onTermTap;
  final ValueChanged<String> onRecentDelete;
  final VoidCallback onClearRecent;

  const SearchIdleView({
    super.key,
    required this.recentSearches,
    required this.onTermTap,
    required this.onRecentDelete,
    required this.onClearRecent,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.only(top: 8, bottom: 120),
      children: [
        if (recentSearches.isNotEmpty) ...[
          RecentSearchesSection(
            searches: recentSearches,
            onTap: onTermTap,
            onDelete: onRecentDelete,
            onClearAll: onClearRecent,
          ),
          const SizedBox(height: 28),
        ],
        TrendingSearchesSection(onTap: onTermTap),
        const SizedBox(height: 28),
        GenreGridSection(onGenreTap: onTermTap),
      ],
    );
  }
}
