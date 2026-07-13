import 'package:flutter/material.dart';

import 'centered_message.dart';

/// Shown when the search/filter yields no results.
class FavouritesNoMatchesState extends StatelessWidget {
  const FavouritesNoMatchesState({super.key});

  @override
  Widget build(BuildContext context) {
    return const CenteredMessage(
      icon: Icons.search_off_rounded,
      title: 'No matches',
      subtitle: 'Try a different search or filter.',
    );
  }
}
