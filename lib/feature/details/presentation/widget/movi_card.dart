import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';
import 'package:movieapp/feature/details/presentation/widget/cast_movie.dart';
import 'package:movieapp/feature/details/presentation/widget/components/action_button.dart';
import 'package:movieapp/feature/details/presentation/widget/components/cast_title.dart';
import 'package:movieapp/feature/details/presentation/widget/components/tagline_section.dart';
import 'package:movieapp/feature/details/presentation/widget/movie_poster.dart';

import '../cubit/details_cubit.dart';
import '../cubit/details_state.dart';
import 'components/genre_section.dart';
import 'components/release_info.dart';

class MovieInfoCard extends StatelessWidget {
  final MovieDetail movie;

  const MovieInfoCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Poster + Movie Info
            MoviePoster(movie: movie),

            SizedBox(height: 12),

            Transform.translate(
              offset: const Offset(0, -40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Genres
                  GenreSection(genres: movie.genres),

                  const SizedBox(height: 12),

                  ReleaseInfo(releaseDate: movie.releaseDate),

                  TaglineSection(),

                  const SizedBox(height: 10),

                  ActionButton(),

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

                  CastTitle(),

                  const SizedBox(height: 12),

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
}
