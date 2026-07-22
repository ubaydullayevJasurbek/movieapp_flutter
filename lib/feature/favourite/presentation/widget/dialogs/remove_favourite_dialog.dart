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
      title: Text('Remove favourite?',
          style: TextStyle(color: AppColors.textPrimary)),
      content: Text(
        'Remove "${movie.title}" from your favourites.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
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
