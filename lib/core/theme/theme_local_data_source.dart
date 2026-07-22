import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// On-device persistence for the user's selected [ThemeMode], backed by
/// `SharedPreferences`.
///
/// [load] returns `null` when the user has never chosen a theme, letting the
/// app fall back to the system setting on first launch. All access is wrapped
/// so a storage failure degrades gracefully to an in-memory-only preference.
class ThemeLocalDataSource {
  static const String _key = 'theme_mode';

  Future<ThemeMode?> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return _decode(prefs.getString(_key));
    } catch (_) {
      return null;
    }
  }

  Future<void> save(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, _encode(mode));
    } catch (_) {
      // Non-fatal: the preference degrades to in-memory only this session.
    }
  }

  ThemeMode? _decode(String? raw) {
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  String _encode(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };
}
