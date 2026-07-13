import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import '../../../domain/entities/favourite_movie.dart';
import 'favourite_card_parts.dart';
import 'pressable.dart';

const _kCard = AppColors.surface;

/// List row: landscape thumbnail with title, meta and genre chips.
class FavouriteListCard extends StatelessWidget {
  final FavouriteMovie movie;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const FavouriteListCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${movie.title}, rating ${movie.voteAverage.toStringAsFixed(1)}',
      button: true,
      child: Pressable(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kCard.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              favouritePoster(movie, width: 84, height: 120),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          favouriteTypeBadge(movie),
                          const SizedBox(width: 8),
                          favouriteRatingPill(movie.voteAverage),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        movie.year,
                        style: const TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                      if (movie.genres.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: movie.genres
                              .take(3)
                              .map((g) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.06),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      g,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 11),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              favouriteHeartButton(onRemove),
            ],
          ),
        ),
      ),
    );
  }
}
