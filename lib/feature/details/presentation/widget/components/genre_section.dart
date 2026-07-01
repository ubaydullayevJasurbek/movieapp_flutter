import 'package:flutter/material.dart';

class GenreSection extends StatelessWidget {
  final List<String> genres;

  const GenreSection({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: genres
          .map(
            (genre) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white24),
              ),
              child: Text(genre, style: const TextStyle(color: Colors.white70)),
            ),
          )
          .toList(),
    );
  }
}
