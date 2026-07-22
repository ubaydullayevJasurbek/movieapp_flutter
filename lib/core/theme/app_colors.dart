import 'package:flutter/material.dart';

/// Single source of truth for the app's colors.
///
/// Tokens are **theme-aware**: neutral colors resolve to their light or dark
/// value based on the active [brightness], which the theme layer applies on
/// every theme change (see `AppTheme.resolve`). Because the whole UI already
/// reads these tokens, flipping the brightness instantly re-colors every
/// screen, card, text and icon without touching individual widgets.
///
/// Brand colors ([primary], [danger], …) are intentionally constant across
/// both themes so they keep their identity and remain usable in `const`
/// widgets. Colors that need to stay legible on a *surface* in both themes
/// (e.g. [rating]) darken for light mode — never use raw `Colors.white` /
/// `Colors.black` for chrome; use these tokens so both themes stay balanced.
class AppColors {
  AppColors._();

  static Brightness _brightness = Brightness.dark;

  static bool get isDark => _brightness == Brightness.dark;

  /// Applied by [AppTheme.resolve] before building [ThemeData] so the widgets
  /// that read these tokens stay in sync with the Material theme.
  static void apply(Brightness brightness) => _brightness = brightness;

  static Brightness get brightness => _brightness;

  // ── Backgrounds & surfaces ──────────────────────────────────────────────
  static Color get background =>
      isDark ? const Color(0xFF000000) : const Color(0xFFF4F6FB);
  static Color get surface =>
      isDark ? const Color(0xFF1B2536) : const Color(0xFFFFFFFF);
  static Color get surfaceHigh =>
      isDark ? const Color(0xFF0B1527) : const Color(0xFFEDF1F8);

  // ── Brand (constant across themes) ──────────────────────────────────────
  static const Color primary = Color(0xFFF6C344); // gold accent
  static const Color onPrimary = Colors.black;
  static const Color danger = Color(0xFFE50914); // remove / primary CTA red
  static const Color tv = Colors.purpleAccent; // TV badge

  /// Gold used as *foreground* on surfaces — stars, ratings, section accent
  /// icons. Unchanged in dark (matches [primary]); a deep, readable amber in
  /// light so it never washes out on white.
  static Color get rating =>
      isDark ? const Color(0xFFF6C344) : const Color(0xFFB45309);

  // ── Text ────────────────────────────────────────────────────────────────
  static Color get textPrimary =>
      isDark ? Colors.white : const Color(0xFF0F172A);
  static Color get textSecondary =>
      isDark ? Colors.white70 : const Color(0xFF334155);
  static Color get textMuted =>
      isDark ? Colors.white54 : const Color(0xFF556072);
  static Color get textFaint =>
      isDark ? Colors.white38 : const Color(0xFF94A3B8);

  // ── Lines & fills ───────────────────────────────────────────────────────
  static Color get border =>
      isDark ? const Color(0x1FFFFFFF) : const Color(0x1A0F172A);
  static Color get divider =>
      isDark ? const Color(0x1FFFFFFF) : const Color(0x140F172A);
  static Color get fill =>
      isDark ? const Color(0x0FFFFFFF) : const Color(0x0F0F172A);

  // ── Frosted-glass panels (bottom nav, settings cards, chips) ────────────
  /// Standard translucent panel. Dark keeps the original 5% white wash; light
  /// becomes a near-opaque frosted white that reads as an elevated card.
  static Color get glass =>
      isDark ? const Color(0x0DFFFFFF) : const Color(0xD9FFFFFF);

  /// Stronger panel for floating chrome such as the bottom navigation.
  static Color get glassStrong =>
      isDark ? const Color(0x14FFFFFF) : const Color(0xF2FFFFFF);

  /// Hairline outline for glass panels.
  static Color get glassBorder =>
      isDark ? const Color(0x26FFFFFF) : const Color(0x140F172A);

  // ── Elevation shadows ───────────────────────────────────────────────────
  /// Soft elevation shadow. Effectively invisible on the pure-black dark
  /// background (unchanged look); a soft slate on light for premium depth.
  static Color get shadow =>
      isDark ? const Color(0x4D000000) : const Color(0x141E293B);
  static Color get shadowStrong =>
      isDark ? const Color(0x4D000000) : const Color(0x1F1E293B);

  // ── Skeleton shimmer bones ──────────────────────────────────────────────
  static Color get skeletonBase =>
      isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
  static Color get skeletonHighlight =>
      isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9);

  // ── Hero "on-scrim" content ─────────────────────────────────────────────
  // Foreground that always sits over the hero's dark image gradient — kept
  // light in *both* themes so it stays legible on photographic backdrops. The
  // scrim itself deepens in light mode (see [heroScrim]) so text never blends
  // into a bright poster.
  static const Color onScrim = Colors.white;
  static const Color onScrimMuted = Colors.white70;
  static const Color onScrimFaint = Colors.white54;
  static const Color onScrimShadow = Colors.black54;

  /// Hero banner accent. Signature bright gold (`#FFD054`) in dark; a deeper,
  /// higher-contrast amber in light so it stays legible against the lighter UI
  /// instead of washing out. [onHeroAccent] is the matching foreground for
  /// *solid* accent fills — black on gold (dark), white on amber (light) — so
  /// buttons like "Watch Now" keep strong contrast in both themes.
  static Color get heroAccent =>
      isDark ? const Color(0xFFFFD054) : const Color(0xFFB45309);
  static Color get onHeroAccent => isDark ? Colors.black : Colors.white;

  /// Theme-aware readability gradient painted over the hero backdrop. Dark mode
  /// keeps the original premium look; light mode adds a soft top scrim and a
  /// stronger bottom fade so the artwork stays visible while text stays sharp.
  static LinearGradient get heroScrim => isDark
      ? const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x00000000), Color(0x8C000000), Color(0xF2000000)],
          stops: [0.15, 0.60, 1.0],
        )
      : const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x4D000000),
            Color(0x1A000000),
            Color(0xBF000000),
            Color(0xF7000000),
          ],
          stops: [0.0, 0.32, 0.66, 1.0],
        );
}
