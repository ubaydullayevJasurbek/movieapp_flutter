import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/feature/details/presentation/pages/movie_details_page.dart';
import '../../../domain/entities/favourite_movie.dart';
import 'favourite_list_card.dart';

/// Scrollable list of swipe-to-remove [FavouriteListCard]s with a shared-axis
/// open transition into the details screen.
class FavouriteListView extends StatelessWidget {
  final List<FavouriteMovie> movies;
  final Future<void> Function(FavouriteMovie) onRemove;
  final Future<bool> Function(FavouriteMovie) confirmRemove;
  final void Function(FavouriteMovie) onRemoved;

  const FavouriteListView({
    super.key,
    required this.movies,
    required this.onRemove,
    required this.confirmRemove,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: movies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, i) {
        final movie = movies[i];
        return Dismissible(
          key: ValueKey(movie.id),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) => confirmRemove(movie),
          onDismissed: (_) => onRemoved(movie),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: AppColors.danger,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
          ),
          child: OpenContainer(
            closedElevation: 0,
            openElevation: 0,
            closedColor: Colors.transparent,
            openColor: AppColors.background,
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (_, open) => FavouriteListCard(
              movie: movie,
              onTap: open,
              onRemove: () => onRemove(movie),
            ),
            openBuilder: (_, __) => MovieDetailsPage(movieId: movie.id),
          ),
        );
      },
    );
  }
}
