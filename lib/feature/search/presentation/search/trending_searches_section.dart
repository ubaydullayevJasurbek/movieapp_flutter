import 'package:flutter/material.dart';
import 'package:movieapp/core/constants/movie_genres.dart';
import 'package:movieapp/core/theme/app_colors.dart';

import 'search_section_header.dart';

/// Horizontally scrolling chips of trending search terms.
class TrendingSearchesSection extends StatelessWidget {
  final ValueChanged<String> onTap;

  const TrendingSearchesSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchSectionHeader(
          icon: Icons.trending_up_rounded,
          title: 'Trending Searches',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: kTrendingSearches.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final term = kTrendingSearches[index];
              return _TrendingChip(
                rank: index + 1,
                label: term,
                onTap: () => onTap(term),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TrendingChip extends StatelessWidget {
  final int rank;
  final String label;
  final VoidCallback onTap;

  const _TrendingChip({
    required this.rank,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$rank',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
