import 'package:flutter/material.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import '../../../domain/entities/favourite_query.dart';

const _kAccent = AppColors.primary;

/// Media-type filter chips (All / Movies / TV Series).
class FavouritesFilterBar extends StatelessWidget {
  final FavouriteFilter filter;
  final ValueChanged<FavouriteFilter> onChanged;

  const FavouritesFilterBar({
    super.key,
    required this.filter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          _chip('All', FavouriteFilter.all),
          _chip('Movies', FavouriteFilter.movies),
          _chip('TV Series', FavouriteFilter.tv),
        ],
      ),
    );
  }

  Widget _chip(String label, FavouriteFilter value) {
    final selected = filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onChanged(value),
      showCheckmark: false,
      color: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? _kAccent
            : Colors.white.withValues(alpha: 0.06),
      ),
      surfaceTintColor: Colors.transparent,
      labelStyle: TextStyle(
        color: selected ? Colors.black : Colors.white70,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide(
        color: selected ? Colors.transparent : Colors.white.withValues(alpha: 0.12),
      ),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
}
