import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton shimmer shared by every home movie section so the loading
/// placeholder is visually identical everywhere. Mirrors the original
/// TrendingSection shimmer exactly (same base/highlight colors, duration and
/// effect). Wrap a section's real layout — fed with fake data — in this widget
/// and toggle [enabled] with the loading state.
class SectionSkeleton extends StatelessWidget {
  final bool enabled;
  final Widget child;

  const SectionSkeleton({
    super.key,
    required this.enabled,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      // Dark keeps the original light-grey bones; light uses a soft slate that
      // matches the search shimmer so every skeleton reads the same per theme.
      effect: ShimmerEffect(
        baseColor: AppColors.isDark
            ? const Color(0xffE0E0E0)
            : const Color(0xFFE2E8F0),
        highlightColor: AppColors.isDark
            ? const Color(0xffF5F5F5)
            : const Color(0xFFF1F5F9),
        duration: const Duration(milliseconds: 1500),
      ),
      child: child,
    );
  }
}
