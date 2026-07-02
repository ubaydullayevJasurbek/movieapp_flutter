import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../details/presentation/pages/movie_details_page.dart';
import '../../../data/model/now_playing_response/now_playing_response.dart';
import '../../cubit/top_rated_cubit/top_rated_cubit.dart';
import '../../cubit/top_rated_cubit/top_rated_state.dart';
import '../item/top_rated_slider.dart';

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
                children: const [
                  Icon(
                    Icons.workspace_premium,
                    color: Color(0xffFFD054),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Top Rated",
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
        const SizedBox(height: 16),

        BlocBuilder<TopRatedCubit, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedLoading) {
              return const SizedBox(
                height: 230,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
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
            if (state is TopRatedLoaded) {
              return Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() => _currentIndex = index);
                      },
                      height: 190,
                      autoPlay: true,
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
                    items: state.movies.map((movie) {
                      return OpenContainer(
                        transitionDuration: const Duration(milliseconds: 400),
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
                          genre:
                              genreMap[movie.genreIds.isNotEmpty
                                  ? movie.genreIds.first
                                  : null],
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
                    count: state.movies.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xffFFD054),
                      dotColor: Colors.white24,
                      dotHeight: 6,
                      dotWidth: 6,
                      expansionFactor: 3.5,
                      spacing: 6,
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
