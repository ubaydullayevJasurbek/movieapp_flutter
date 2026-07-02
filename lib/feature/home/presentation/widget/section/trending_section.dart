import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/feature/details/presentation/pages/movie_details_page.dart';

import '../../cubit/movie_cubit/movie_cubit.dart';
import '../../cubit/movie_cubit/movie_state.dart';
import '../item/trending_item.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.trending_up, color: Color(0xffFFD054), size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Trending Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const SizedBox(
                height: 210,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
            if (state is MovieError) {
              return SizedBox(
                height: 210,
                child: Center(
                  child: Text(
                    'Xatolik: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            if (state is MovieLoaded) {
              return SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: OpenContainer(
                        transitionDuration: const Duration(milliseconds: 400),
                        transitionType: ContainerTransitionType.fade,
                        closedElevation: 0,
                        closedColor: Colors.transparent,
                        openColor: Colors.transparent,
                        middleColor: Colors.transparent,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        closedBuilder: (context, openContainer) => TrendingItem(
                          title: movie.title,
                          heroTag: "poster_${movie.id}",
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          rating: movie.voteAverage,
                          year: movie.releaseDate.year,
                          onTap: openContainer,
                        ),
                        openBuilder: (context, closeContainer) =>
                            MovieDetailsPage(movieId: movie.id),
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
