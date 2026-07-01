import 'package:flutter/material.dart';
import 'package:movieapp/core/utils/movie_utils.dart';
import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';

class MoviePoster extends StatelessWidget {
  final MovieDetail movie;

  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: const Offset(0, -55),
          child: Hero(
            tag: "poster_${movie.id}",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${movie.posterPath ?? ""}",
                width: 120,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 180,
                    color: Colors.grey.shade800,
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Text(
                      movie.releaseDate.year.toString(),
                      style: const TextStyle(color: Colors.white54),
                    ),

                    const SizedBox(width: 6),

                    const Text(
                      "•",
                      style: TextStyle(color: Colors.white38),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      MovieUtils.runtime(movie.runtime),
                      style: const TextStyle(color: Colors.white54),
                    ),

                    const SizedBox(width: 6),

                    const Text(
                      "•",
                      style: TextStyle(color: Colors.white38),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text(
                        movie.adult ? "18+" : "PG-13",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 22,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(width: 3),

                    const Text(
                      "/10",
                      style: TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "(${movie.voteCount})",
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
