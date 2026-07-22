import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../details/presentation/pages/movie_details_page.dart';
import '../../../data/model/top_rated_response/top_rated_response.dart';
import '../../cubit/top_rated_cubit/top_rated_cubit.dart';
import '../../cubit/top_rated_cubit/top_rated_state.dart';
import '../item/top_rated_slider.dart';
import 'section_skeleton.dart';

class TopMoviesSection extends StatefulWidget {
  const TopMoviesSection({super.key});

  @override
  State<TopMoviesSection> createState() => _TopMoviesSectionState();
}

class _TopMoviesSectionState extends State<TopMoviesSection> {
  int _currentIndex = 0;

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
                children: [
                  Icon(
                    Icons.workspace_premium,
                    color: AppColors.rating,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Top Rated",
                    style: TextStyle(
                      color: AppColors.textPrimary,
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
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.textMuted,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        BlocBuilder<TopRatedCubit, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedError) {
              return SizedBox(
                height: 230,
                child: Center(
                  child: Text(
                    "Xatolik: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }

            final isLoading = state is! TopRatedLoaded;
            final movies = state is TopRatedLoaded ? state.movies : _fakeMovies;

            return SectionSkeleton(
              enabled: isLoading,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() => _currentIndex = index);
                      },
                      height: 190,
                      autoPlay: !isLoading,
                      autoPlayCurve: Curves.easeInOutCubic,
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayInterval: const Duration(seconds: 4),
                      enlargeCenterPage: true,
                      enlargeFactor: 0.14,
                      viewportFraction: 0.82,
                      clipBehavior: Clip.none,
                    ),
                    items: movies.map((movie) {
                      final genre = genreMap[movie.genreIds.isNotEmpty
                          ? movie.genreIds.first
                          : null];

                      if (isLoading) {
                        return TopRatedSlider(
                          title: movie.title,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                          rating: movie.voteAverage,
                          genre: genre,
                          year: movie.releaseDate.year,
                          onTap: () {},
                        );
                      }

                      return OpenContainer(
                        transitionDuration: const Duration(seconds: 1),
                        transitionType: ContainerTransitionType.fade,
                        closedElevation: 0,
                        closedColor: Colors.transparent,
                        openColor: Colors.transparent,
                        middleColor: Colors.transparent,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        closedBuilder: (context, openContainer) => TopRatedSlider(
                          title: movie.title,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                          rating: movie.voteAverage,
                          genre: genre,
                          year: movie.releaseDate.year,
                          onTap: openContainer,
                        ),
                        openBuilder: (context, closeContainer) =>
                            MovieDetailsPage(movieId: movie.id),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: movies.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.rating,
                      dotColor: AppColors.textFaint,
                      dotHeight: 6,
                      dotWidth: 6,
                      expansionFactor: 3.5,
                      spacing: 6,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

final _fakeMovies = List.generate(6, (index) => Result.fake(id: index));
