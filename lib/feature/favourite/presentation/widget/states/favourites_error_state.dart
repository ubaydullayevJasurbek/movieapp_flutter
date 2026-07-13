import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import 'centered_message.dart';

const _kAccent = AppColors.primary;

/// Shown when loading favourites fails, with a retry action.
class FavouritesErrorState extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const FavouritesErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return CenteredMessage(
      icon: Icons.wifi_off_rounded,
      title: 'Something went wrong',
      subtitle: message ?? 'Check your connection and try again.',
      action: FilledButton.icon(
        onPressed: onRetry,
        style: FilledButton.styleFrom(
            backgroundColor: _kAccent, foregroundColor: Colors.black),
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Retry'),
      ),
    );
  }
}
