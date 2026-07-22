// Tests for the app theme system: the ThemeCubit state logic and the Profile
// theme switch that drives it.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/core/theme/theme_cubit.dart';
import 'package:movieapp/core/theme/theme_local_data_source.dart';
import 'package:movieapp/feature/profile/presentation/widget/theme_switch_tile.dart';

/// In-memory stand-in for [ThemeLocalDataSource] so tests never touch disk and
/// can assert what would be persisted.
class _FakeThemeStorage extends ThemeLocalDataSource {
  ThemeMode? stored;
  ThemeMode? saved;

  @override
  Future<ThemeMode?> load() async => stored;

  @override
  Future<void> save(ThemeMode mode) async {
    saved = mode;
  }
}

void main() {
  group('ThemeCubit', () {
    test('starts from the provided initial mode', () {
      final cubit = ThemeCubit(
        initialMode: ThemeMode.light,
        systemBrightness: Brightness.dark,
        storage: _FakeThemeStorage(),
      );
      addTearDown(cubit.close);

      expect(cubit.state.mode, ThemeMode.light);
      expect(cubit.state.isDark, isFalse);
    });

    test('toggleDark switches modes and persists the selection', () {
      final storage = _FakeThemeStorage();
      final cubit = ThemeCubit(
        initialMode: ThemeMode.light,
        systemBrightness: Brightness.light,
        storage: storage,
      );
      addTearDown(cubit.close);

      cubit.toggleDark(true);
      expect(cubit.state.mode, ThemeMode.dark);
      expect(cubit.state.isDark, isTrue);
      expect(storage.saved, ThemeMode.dark);

      cubit.toggleDark(false);
      expect(cubit.state.mode, ThemeMode.light);
      expect(cubit.state.isDark, isFalse);
      expect(storage.saved, ThemeMode.light);
    });

    test('system mode resolves brightness from the platform', () {
      final cubit = ThemeCubit(
        initialMode: ThemeMode.system,
        systemBrightness: Brightness.dark,
        storage: _FakeThemeStorage(),
      );
      addTearDown(cubit.close);

      expect(cubit.state.isDark, isTrue);

      cubit.updateSystemBrightness(Brightness.light);
      expect(cubit.state.isDark, isFalse);
    });
  });

  group('AppColors adapts between light and dark', () {
    // AppColors is a global static token layer; restore the app default so
    // these tests never leak brightness into the widget tests below.
    tearDown(() => AppColors.apply(Brightness.dark));

    test('hero accent is bright gold in dark, derived amber in light', () {
      AppColors.apply(Brightness.dark);
      expect(AppColors.heroAccent, const Color(0xFFFFD054));
      expect(AppColors.onHeroAccent, Colors.black); // black on gold

      AppColors.apply(Brightness.light);
      expect(AppColors.heroAccent, const Color(0xFFB45309));
      expect(AppColors.onHeroAccent, Colors.white); // white on amber
    });

    test('neutral tokens flip so every component re-colors per theme', () {
      AppColors.apply(Brightness.dark);
      final darkBg = AppColors.background;
      final darkText = AppColors.textPrimary;
      final darkSurface = AppColors.surface;
      final darkRating = AppColors.rating;

      AppColors.apply(Brightness.light);
      // Each token must resolve to a *different* value in the other theme,
      // which is what makes the shared widgets adapt automatically.
      expect(AppColors.background, isNot(darkBg));
      expect(AppColors.textPrimary, isNot(darkText));
      expect(AppColors.surface, isNot(darkSurface));
      expect(AppColors.rating, isNot(darkRating));

      // Light values are the premium light palette.
      expect(AppColors.textPrimary, const Color(0xFF0F172A));
      expect(AppColors.rating, const Color(0xFFB45309));
    });
  });

  testWidgets('ThemeSwitchTile reflects and toggles the active theme',
      (tester) async {
    final cubit = ThemeCubit(
      initialMode: ThemeMode.light,
      systemBrightness: Brightness.light,
      storage: _FakeThemeStorage(),
    );
    addTearDown(cubit.close);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const Scaffold(body: ThemeSwitchTile()),
        ),
      ),
    );

    Switch readSwitch() => tester.widget<Switch>(find.byType(Switch));

    // Light theme => switch is OFF.
    expect(readSwitch().value, isFalse);

    // Flipping the switch ON must enable dark mode in real time.
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(cubit.state.mode, ThemeMode.dark);
    expect(readSwitch().value, isTrue);
  });
}
