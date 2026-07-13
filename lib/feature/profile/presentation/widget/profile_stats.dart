import 'package:flutter/material.dart';

import '../model/profile_view_data.dart';
import 'stat_card.dart';

/// Responsive statistics grid: two columns on phones, four on wide screens.
class ProfileStats extends StatelessWidget {
  final List<ProfileStat> stats;

  const ProfileStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    const spacing = 12.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final perRow = constraints.maxWidth >= 520 ? 4 : 2;
        final width =
            (constraints.maxWidth - spacing * (perRow - 1)) / perRow;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final stat in stats)
              SizedBox(width: width, child: StatCard(stat: stat)),
          ],
        );
      },
    );
  }
}
