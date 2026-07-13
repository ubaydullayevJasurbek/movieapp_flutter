import 'package:flutter/material.dart';

import '../../../domain/entities/favourite_movie.dart';
import 'favourite_card_parts.dart';
import 'pressable.dart';

/// Grid tile: portrait poster with overlaid rating, badge and remove button.
class FavouriteGridCard extends StatelessWidget {
  final FavouriteMovie movie;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const FavouriteGridCard({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: favouritePoster(movie,
                        width: double.infinity, height: double.infinity),
                  ),
                  Positioned(
                      top: 8, left: 8, child: favouriteRatingPill(movie.voteAverage)),
                  Positioned(top: 8, right: 8, child: favouriteHeartButton(onRemove)),
                  Positioned(bottom: 8, left: 8, child: favouriteTypeBadge(movie)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              movie.genres.isNotEmpty
                  ? '${movie.year} · ${movie.genres.first}'
                  : movie.year,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
