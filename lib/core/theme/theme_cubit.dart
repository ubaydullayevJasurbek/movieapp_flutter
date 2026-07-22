import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_local_data_source.dart';

/// Immutable theme state. [mode] drives the whole app; [system] is the current
/// platform brightness, used to resolve [ThemeMode.system].
class ThemeState extends Equatable {
  final ThemeMode mode;
  final Brightness system;

  const ThemeState({required this.mode, required this.system});

  /// The brightness actually shown, after resolving [ThemeMode.system].
  Brightness get effectiveBrightness => switch (mode) {
        ThemeMode.light => Brightness.light,
        ThemeMode.dark => Brightness.dark,
        ThemeMode.system => system,
      };

  bool get isDark => effectiveBrightness == Brightness.dark;

  ThemeState copyWith({ThemeMode? mode, Brightness? system}) => ThemeState(
        mode: mode ?? this.mode,
        system: system ?? this.system,
      );

  @override
  List<Object?> get props => [mode, system];
}

/// Centralized theme manager and single source of truth for the app theme.
///
/// Holds the selected [ThemeMode], persists it, and exposes intent methods that
/// emit a new state immediately so the UI switches in real time.
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeMode initialMode,
    required Brightness systemBrightness,
    ThemeLocalDataSource? storage,
  })  : _storage = storage ?? ThemeLocalDataSource(),
        super(ThemeState(mode: initialMode, system: systemBrightness));

  final ThemeLocalDataSource _storage;

  /// Keeps [ThemeMode.system] in sync when the OS brightness changes at runtime.
  void updateSystemBrightness(Brightness brightness) {
    if (brightness == state.system) return;
    emit(state.copyWith(system: brightness));
  }

  /// Selects an explicit mode and persists it.
  void setMode(ThemeMode mode) {
    if (mode == state.mode) return;
    emit(state.copyWith(mode: mode));
    _storage.save(mode);
  }

  /// Toggle used by the Profile switch: picks an explicit light/dark mode.
  void toggleDark(bool isDark) =>
      setMode(isDark ? ThemeMode.dark : ThemeMode.light);
}
