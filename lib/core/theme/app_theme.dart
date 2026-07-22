import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Builds the app's Material 3 [ThemeData] for a given [Brightness].
///
/// Both the light and dark themes are derived from the single [AppColors]
/// source of truth. [resolve] first applies the brightness to [AppColors] so
/// the custom widgets that read those tokens render with the same palette as
/// the Material components in the returned theme.
class AppTheme {
  AppTheme._();

  static ThemeData get dark => resolve(Brightness.dark);
  static ThemeData get light => resolve(Brightness.light);

  static ThemeData resolve(Brightness brightness) {
    // Keep the token layer in sync with the theme being built.
    AppColors.apply(brightness);

    final isDark = brightness == Brightness.dark;

    final scheme =
        (isDark ? const ColorScheme.dark() : const ColorScheme.light())
            .copyWith(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primary,
      onSecondary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.danger,
      onError: Colors.white,
      outline: AppColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      primaryColor: AppColors.primary,
      dividerColor: AppColors.divider,
      splashColor: AppColors.textPrimary.withValues(alpha: 0.08),
      highlightColor: AppColors.textPrimary.withValues(alpha: 0.04),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      dividerTheme: DividerThemeData(color: AppColors.divider, thickness: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardColor: AppColors.surface,
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: TextStyle(color: AppColors.textPrimary),
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.fill,
        selectedColor: AppColors.primary,
        side: BorderSide(color: AppColors.border),
        labelStyle: TextStyle(color: AppColors.textSecondary),
        secondaryLabelStyle: const TextStyle(color: AppColors.onPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.danger,
          foregroundColor: Colors.white,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
    );
  }
}
