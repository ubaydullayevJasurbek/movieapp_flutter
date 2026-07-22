import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import '../../../domain/entities/favourite_movie.dart';

const _kAccent = AppColors.primary;
Color get _kCard => AppColors.surface;

/// Rounded poster image with a graceful fallback, shared by both cards.
Widget favouritePoster(
  FavouriteMovie movie, {
  required double width,
  required double height,
}) {
  final radius = BorderRadius.circular(18);
  return ClipRRect(
    borderRadius: radius,
    child: movie.posterUrl == null
        ? _posterFallback(width, height)
        : CachedNetworkImage(
            imageUrl: movie.posterUrl!,
            width: width,
            height: height,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: _kCard),
            errorWidget: (_, __, ___) => _posterFallback(width, height),
          ),
  );
}

Widget _posterFallback(double width, double height) => Container(
      width: width,
      height: height,
      color: _kCard,
      child: const Icon(Icons.movie_rounded, color: Colors.white24, size: 34),
    );

Widget favouriteRatingPill(double rating) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 14, color: _kAccent),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: _kAccent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

Widget favouriteTypeBadge(FavouriteMovie movie) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        movie.isTv ? 'TV' : 'Movie',
        style: TextStyle(
          color: movie.isTv ? AppColors.tv : _kAccent,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );

Widget favouriteHeartButton(VoidCallback onRemove) => Semantics(
      button: true,
      label: 'Remove from favourites',
      child: Material(
        color: Colors.black.withValues(alpha: 0.55),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onRemove,
          child: const Padding(
            padding: EdgeInsets.all(9),
            child: Icon(Icons.favorite_rounded, color: AppColors.danger, size: 18),
          ),
        ),
      ),
    );
