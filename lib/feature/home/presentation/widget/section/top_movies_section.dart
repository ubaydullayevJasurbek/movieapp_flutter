import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Top Movies",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        const SizedBox(height: 12),

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
                        setState(
                          () => _currentIndex = index,
                        ); // 👈 endi ishlaydi
                      },
                      height: 170,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      enlargeFactor: 0.08,
                      viewportFraction: 0.82,
                      clipBehavior: Clip.none,
                    ),
                    items: state.movies.map((movie) {
                      return TopRatedSlider(
                        title: movie.title,
                        imageUrl:
                            'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                        rating: movie.voteAverage,
                        genre:
                            genreMap[movie.genreIds.isNotEmpty
                                ? movie.genreIds.first
                                : null],
                        year: movie.releaseDate.year,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: state.movies.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.white24,
                      dotHeight: 5,
                      dotWidth: 5,
                      expansionFactor: 3,
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
