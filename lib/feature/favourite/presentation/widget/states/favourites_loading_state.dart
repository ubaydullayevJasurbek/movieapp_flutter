import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:movieapp/core/theme/app_colors.dart';

/// Skeleton grid shown while favourites are loading.
class FavouritesLoadingState extends StatelessWidget {
  const FavouritesLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          childAspectRatio: 0.56,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Placeholder title'),
            const SizedBox(height: 4),
            const Text('2024 · Genre'),
          ],
        ),
      ),
    );
  }
}
