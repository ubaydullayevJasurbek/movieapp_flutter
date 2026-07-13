import 'package:flutter/material.dart';

/// A single browsable genre used by the search screen's genre grid.
class MovieGenre {
  final int id;
  final String name;
  final IconData icon;
  final List<Color> gradient;

  const MovieGenre({
    required this.id,
    required this.name,
    required this.icon,
    required this.gradient,
  });
}

/// Single source of truth for TMDB movie genres.
///
/// [map] resolves genre ids (as returned inside search results) to their
/// display names, while [grid] drives the premium genre section.
class MovieGenres {
  MovieGenres._();

  static const Map<int, String> map = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  /// Maps a list of genre ids to their names, skipping unknown ids.
  static List<String> namesFor(List<int> ids) => ids
      .map((id) => map[id])
      .whereType<String>()
      .toList(growable: false);

  static const List<MovieGenre> grid = [
    MovieGenre(
      id: 28,
      name: 'Action',
      icon: Icons.local_fire_department_rounded,
      gradient: [Color(0xFFFF6B6B), Color(0xFFEE0979)],
    ),
    MovieGenre(
      id: 35,
      name: 'Comedy',
      icon: Icons.emoji_emotions_rounded,
      gradient: [Color(0xFFF7971E), Color(0xFFFFD200)],
    ),
    MovieGenre(
      id: 18,
      name: 'Drama',
      icon: Icons.theater_comedy_rounded,
      gradient: [Color(0xFF667EEA), Color(0xFF764BA2)],
    ),
    MovieGenre(
      id: 27,
      name: 'Horror',
      icon: Icons.dark_mode_rounded,
      gradient: [Color(0xFF232526), Color(0xFF414345)],
    ),
    MovieGenre(
      id: 878,
      name: 'Sci-Fi',
      icon: Icons.rocket_launch_rounded,
      gradient: [Color(0xFF00C6FF), Color(0xFF0072FF)],
    ),
    MovieGenre(
      id: 10749,
      name: 'Romance',
      icon: Icons.favorite_rounded,
      gradient: [Color(0xFFFF9A9E), Color(0xFFFF5F86)],
    ),
    MovieGenre(
      id: 16,
      name: 'Animation',
      icon: Icons.auto_awesome_rounded,
      gradient: [Color(0xFF43E97B), Color(0xFF38F9D7)],
    ),
    MovieGenre(
      id: 53,
      name: 'Thriller',
      icon: Icons.bolt_rounded,
      gradient: [Color(0xFF4E54C8), Color(0xFF8F94FB)],
    ),
  ];
}

/// Static, curated trending search terms surfaced on the idle search screen.
const List<String> kTrendingSearches = [
  'Oppenheimer',
  'Dune',
  'Batman',
  'Spider-Man',
  'Avatar',
  'Interstellar',
  'Joker',
  'Inception',
];
