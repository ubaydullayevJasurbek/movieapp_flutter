import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/core/theme/theme_cubit.dart';

import 'settings_tile.dart';

/// Profile row that switches the whole app between light and dark in real time.
///
/// Reads the [ThemeCubit] (the single source of truth) so only this tile — and
/// the app root that applies the theme — rebuild when the theme changes.
class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDark;
        return SettingsTile(
          icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          title: 'Theme',
          subtitle: isDark ? 'Dark' : 'Light',
          onTap: () => context.read<ThemeCubit>().toggleDark(!isDark),
          trailing: Switch.adaptive(
            value: isDark,
            onChanged: (value) => context.read<ThemeCubit>().toggleDark(value),
            activeThumbColor: AppColors.onPrimary,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: AppColors.textMuted,
            inactiveTrackColor: AppColors.fill,
          ),
        );
      },
    );
  }
}
