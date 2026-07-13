import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/feature/details/presentation/pages/movie_details_page.dart';
import '../../../domain/entities/favourite_movie.dart';
import 'favourite_grid_card.dart';

/// Scrollable grid of [FavouriteGridCard]s with a shared-axis open transition
/// into the details screen.
class FavouriteGridView extends StatelessWidget {
  final List<FavouriteMovie> movies;
  final Future<void> Function(FavouriteMovie) onRemove;

  const FavouriteGridView({
    super.key,
    required this.movies,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
        childAspectRatio: 0.56,
      ),
      itemCount: movies.length,
      itemBuilder: (context, i) {
        final movie = movies[i];
        return OpenContainer(
          key: ValueKey(movie.id),
          closedElevation: 0,
          openElevation: 0,
          closedColor: Colors.transparent,
          openColor: AppColors.background,
          transitionType: ContainerTransitionType.fadeThrough,
          closedBuilder: (_, open) => FavouriteGridCard(
            movie: movie,
            onTap: open,
            onRemove: () => onRemove(movie),
          ),
          openBuilder: (_, __) => MovieDetailsPage(movieId: movie.id),
        );
      },
    );
  }
}
