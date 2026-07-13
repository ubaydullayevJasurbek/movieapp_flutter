import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import '../../../domain/entities/favourite_query.dart';

/// Human-readable label for each sort option.
extension FavouriteSortLabel on FavouriteSort {
  String get label => switch (this) {
        FavouriteSort.recent => 'Recently Added',
        FavouriteSort.rating => 'Rating',
        FavouriteSort.release => 'Release Date',
        FavouriteSort.az => 'A–Z',
      };
}

/// Result count with the sort menu and grid/list view toggle.
class FavouritesToolbar extends StatelessWidget {
  final int count;
  final FavouriteSort sort;
  final bool grid;
  final ValueChanged<FavouriteSort> onSort;
  final VoidCallback onToggleView;

  const FavouritesToolbar({
    super.key,
    required this.count,
    required this.sort,
    required this.grid,
    required this.onSort,
    required this.onToggleView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$count ${count == 1 ? 'result' : 'results'}',
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ),
          PopupMenuButton<FavouriteSort>(
            initialValue: sort,
            onSelected: onSort,
            color: AppColors.surface,
            tooltip: 'Sort',
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            itemBuilder: (_) => FavouriteSort.values
                .map((s) => PopupMenuItem(
                      value: s,
                      child: Text(s.label,
                          style: const TextStyle(color: Colors.white)),
                    ))
                .toList(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.sort_rounded, color: Colors.white70, size: 18),
                  const SizedBox(width: 6),
                  Text(sort.label,
                      style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Tooltip(
            message: grid ? 'List view' : 'Grid view',
            child: Material(
              color: Colors.white.withValues(alpha: 0.06),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onToggleView,
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Icon(
                    grid ? Icons.view_list_rounded : Icons.grid_view_rounded,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
