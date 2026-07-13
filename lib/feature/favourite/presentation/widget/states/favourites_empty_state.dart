import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import 'centered_message.dart';

const _kAccent = AppColors.primary;

/// Shown when no favourites have been saved yet, with a browse CTA.
class FavouritesEmptyState extends StatelessWidget {
  final VoidCallback? onBrowse;

  const FavouritesEmptyState({super.key, required this.onBrowse});

  @override
  Widget build(BuildContext context) {
    return CenteredMessage(
      icon: Icons.favorite_border_rounded,
      title: 'No favourites yet',
      subtitle: 'Tap the bookmark on any movie to save it here for later.',
      action: FilledButton.icon(
        onPressed: onBrowse,
        style: FilledButton.styleFrom(
          backgroundColor: _kAccent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        ),
        icon: const Icon(Icons.movie_filter_rounded),
        label: const Text('Browse movies',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}
