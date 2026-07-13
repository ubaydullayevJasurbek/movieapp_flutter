import 'package:flutter/material.dart';

import '../model/profile_view_data.dart';
import 'continue_watching_card.dart';
import 'section_header.dart';

/// Horizontal carousel of partially-watched titles.
class ContinueWatchingSection extends StatelessWidget {
  final List<ContinueWatchingItem> items;
  final ValueChanged<ContinueWatchingItem>? onTap;

  const ContinueWatchingSection({super.key, required this.items, this.onTap});

  static const double _horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: SectionHeader(title: 'Continue Watching', actionLabel: 'See all'),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 256,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = items[index];
              return ContinueWatchingCard(
                item: item,
                onTap: onTap == null ? null : () => onTap!(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
