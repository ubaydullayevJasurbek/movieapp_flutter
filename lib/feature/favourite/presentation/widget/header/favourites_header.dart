import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';

/// Title bar showing the favourites icon and the saved-title count.
class FavouritesHeader extends StatelessWidget {
  final int count;

  const FavouritesHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.danger, AppColors.primary],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Favourites',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  count == 1 ? '1 title saved' : '$count titles saved',
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
