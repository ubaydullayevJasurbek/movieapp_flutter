import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/feature/favourite/domain/entities/favourite_movie.dart';
import 'package:movieapp/feature/favourite/presentation/cubit/favourites_cubit.dart';

import '../search_cubit/search_movie.dart';


/// Premium result card: poster, rating pill, favourite toggle, title,
/// genres and release year.
class SearchMovieCard extends StatelessWidget {
  final SearchMovie movie;
  final VoidCallback onTap;

  const SearchMovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _Pressable(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: _poster()),
                Positioned(top: 8, left: 8, child: _ratingPill()),
                Positioned(top: 8, right: 8, child: _FavouriteButton(movie: movie)),
                if (movie.year != null)
                  Positioned(bottom: 8, left: 8, child: _yearBadge(movie.year!)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            movie.genres.isNotEmpty ? movie.genres.take(2).join(' · ') : 'Movie',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _poster() {
    return Hero(
      tag: 'search_poster_${movie.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: movie.posterUrl == null
            ? _posterFallback()
            : CachedNetworkImage(
                imageUrl: movie.posterUrl!,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (_, _) => Container(color: AppColors.surface),
                errorWidget: (_, _, _) => _posterFallback(),
              ),
      ),
    );
  }

  Widget _posterFallback() => Container(
        color: AppColors.surface,
        alignment: Alignment.center,
        child: const Icon(Icons.movie_rounded, color: Colors.white24, size: 34),
      );

  Widget _ratingPill() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, size: 14, color: AppColors.primary),
            const SizedBox(width: 3),
            Text(
              movie.ratingText,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

  Widget _yearBadge(String year) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          year,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}

/// Heart button wired to the shared favourites singleton, with a scale
/// animation on toggle.
class _FavouriteButton extends StatelessWidget {
  final SearchMovie movie;

  const _FavouriteButton({required this.movie});

  FavouriteMovie _toFavourite() => FavouriteMovie(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        voteAverage: movie.voteAverage,
        releaseDate: movie.releaseDateTime,
        genres: movie.genres,
        mediaType: 'movie',
        addedAt: DateTime.now(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      bloc: FavouritesCubit.instance,
      builder: (context, _) {
        final saved = FavouritesCubit.instance.contains(movie.id);
        return Semantics(
          button: true,
          label: saved ? 'Remove from favourites' : 'Add to favourites',
          child: Material(
            color: Colors.black.withValues(alpha: 0.55),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                FavouritesCubit.instance.toggle(_toFavourite());
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                      content: Text(saved
                          ? 'Removed from favourites'
                          : 'Added to favourites'),
                    ),
                  );
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    saved
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    key: ValueKey(saved),
                    size: 18,
                    color: saved ? AppColors.danger : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Small scale-on-press wrapper shared by the card.
class _Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _Pressable({required this.child, required this.onTap});

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
