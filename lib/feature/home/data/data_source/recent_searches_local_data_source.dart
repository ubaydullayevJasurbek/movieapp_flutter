import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// On-device persistence for the user's recent search terms.
///
/// Backed by a small JSON file in the app documents directory (using the
/// already-available `path_provider`, without introducing a new Isar schema).
/// An in-memory cache keeps reads after the first one cheap. All mutating
/// methods return the updated list so callers can emit it directly.
class RecentSearchesLocalDataSource {
  RecentSearchesLocalDataSource({int maxEntries = 10})
      : _maxEntries = maxEntries;

  static const String _fileName = 'recent_searches.json';

  final int _maxEntries;

  List<String>? _cache;
  File? _file;

  Future<File> _resolveFile() async {
    if (_file != null) return _file!;
    final dir = await getApplicationDocumentsDirectory();
    return _file = File('${dir.path}/$_fileName');
  }

  Future<List<String>> getAll() async {
    if (_cache != null) return List.unmodifiable(_cache!);
    try {
      final file = await _resolveFile();
      if (!await file.exists()) {
        _cache = <String>[];
      } else {
        final decoded = jsonDecode(await file.readAsString());
        _cache = decoded is List
            ? decoded.whereType<String>().toList()
            : <String>[];
      }
    } catch (_) {
      _cache = <String>[];
    }
    return List.unmodifiable(_cache!);
  }

  Future<List<String>> add(String term) async {
    final trimmed = term.trim();
    if (trimmed.isEmpty) return getAll();

    final items = List<String>.from(await getAll())
      ..removeWhere((e) => e.toLowerCase() == trimmed.toLowerCase());
    items.insert(0, trimmed);
    if (items.length > _maxEntries) {
      items.removeRange(_maxEntries, items.length);
    }
    return _persist(items);
  }

  Future<List<String>> remove(String term) async {
    final items = List<String>.from(await getAll())
      ..removeWhere((e) => e.toLowerCase() == term.toLowerCase());
    return _persist(items);
  }

  Future<List<String>> clear() => _persist(<String>[]);

  Future<List<String>> _persist(List<String> items) async {
    _cache = items;
    try {
      final file = await _resolveFile();
      await file.writeAsString(jsonEncode(items));
    } catch (_) {
      // Non-fatal: recent searches degrade to in-memory only this session.
    }
    return List.unmodifiable(items);
  }
}
