import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import '../../../domain/entities/favourite_movie.dart';

/// Asks the user to confirm removing [movie]. Resolves to `true` when the
/// removal is confirmed, `false` otherwise.
Future<bool> showRemoveFavouriteDialog(
  BuildContext context,
  FavouriteMovie movie,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Remove favourite?',
          style: TextStyle(color: Colors.white)),
      content: Text(
        'Remove "${movie.title}" from your favourites.',
        style: const TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Remove'),
        ),
      ],
    ),
  );
  return result ?? false;
}
