import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import '../../../../details/presentation/pages/movie_details_page.dart';
import '../../../data/model/tv_series_response/tv_series_response.dart';
import '../../cubit/tv_series_cubit/tv_series_cubit.dart';
import '../../cubit/tv_series_cubit/tv_series_state.dart';
import '../item/tv_series_item.dart';
import 'section_skeleton.dart';

class TvSeriesSection extends StatelessWidget {
  const TvSeriesSection({super.key});

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
                    Icons.live_tv_rounded,
                    color: AppColors.rating,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "TV Series",
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
        const SizedBox(height: 14),

        BlocBuilder<TvSeriesCubit, TVSeriesState>(
          builder: (context, state) {
            if (state is TVSeriesError) {
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

            final isLoading = state is! TVSeriesLoaded;
            final movies = state is TVSeriesLoaded ? state.movies : _fakeMovies;

            return SectionSkeleton(
              enabled: isLoading,
              child: SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    final imageUrl =
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}';

                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: isLoading
                          ? TvSeriesItem(
                              title: movie.name,
                              heroTag: "poster_${movie.id}",
                              imageUrl: imageUrl,
                              rating: movie.voteAverage,
                              year: '${movie.firstAirDate.year}',
                              onTap: () {},
                              showHero: false,
                            )
                          : OpenContainer(
                              transitionDuration: const Duration(
                                milliseconds: 400,
                              ),
                              transitionType: ContainerTransitionType.fade,
                              closedElevation: 0,
                              closedColor: Colors.transparent,
                              openColor: Colors.transparent,
                              middleColor: Colors.transparent,
                              closedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              closedBuilder: (context, openContainer) =>
                                  TvSeriesItem(
                                    title: movie.name,
                                    heroTag: "poster_${movie.id}",
                                    imageUrl: imageUrl,
                                    rating: movie.voteAverage,
                                    year: '${movie.firstAirDate.year}',
                                    onTap: openContainer,
                                  ),
                              openBuilder: (context, closeContainer) =>
                                  MovieDetailsPage(movieId: movie.id),
                            ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

final _fakeMovies = List.generate(6, (index) => Result.fake(id: index));
