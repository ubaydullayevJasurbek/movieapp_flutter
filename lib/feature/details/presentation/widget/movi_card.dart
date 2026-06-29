import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';
import 'package:movieapp/feature/details/presentation/widget/cast_movie.dart';

import '../cubit/details_cubit.dart';
import '../cubit/details_state.dart';

class MovieInfoCard extends StatelessWidget {
  final MovieDetail movie;

  const MovieInfoCard({super.key, required this.movie});

  String _runtime(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return "${h}h ${m}m";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff08111F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Poster + Movie Info
            Row(
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
                        errorBuilder: (_, __, ___) {
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
                              _runtime(movie.runtime),
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
            ),

            SizedBox(height: 12),
            Transform.translate(
              offset: const Offset(0, -40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Genres
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: movie.genres
                        .map(
                          (genre) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text(
                          genre,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    )
                        .toList(),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Released ${DateFormat('MMMM d, yyyy').format(movie.releaseDate)}",
                    style: const TextStyle(color: Colors.white60, fontSize: 15),
                  ),

                  if ((movie.tagline ?? "").isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Text(
                      movie.tagline!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                  ],

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffE50914),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            icon: const Icon(Icons.play_arrow, color: Colors.white),
                            label: const Text(
                              "Watch Trailer",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),
                      _icon(Icons.favorite_border),
                      const SizedBox(width: 12),
                      _icon(Icons.add),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Overview",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    movie.overview,
                    style: const TextStyle(
                      color: Colors.white70,
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 12),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Cast",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xffE50914),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),

                    ],
                  ),

                  BlocBuilder<DetailsCubit, DetailsState>(
                    builder: (context, state) {
                      if (state is DetailsLoaded && state.cast.isNotEmpty) {
                        return CastMovie(castList: state.cast);
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}