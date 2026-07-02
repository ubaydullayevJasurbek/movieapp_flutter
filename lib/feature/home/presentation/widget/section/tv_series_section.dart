import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../details/presentation/pages/movie_details_page.dart';
import '../../cubit/tv_series_cubit/tv_series_cubit.dart';
import '../../cubit/tv_series_cubit/tv_series_state.dart';
import '../item/tv_series_item.dart';

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
                children: const [
                  Icon(Icons.live_tv_rounded, color: Color(0xffFFD054), size: 20),
                  SizedBox(width: 8),
                  Text(
                    "TV Series",
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

        BlocBuilder<TvSeriesCubit, TVSeriesState>(
          builder: (context, state) {
            if (state is TVSeriesLoading) {
              return const SizedBox(
                height: 280,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
            if (state is TVSeriesError) {
              return SizedBox(
                height: 280,
                child: Center(
                  child: Text(
                    'Xatolik: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            if (state is TVSeriesLoaded) {
              return SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: OpenContainer(
                        transitionDuration: const Duration(milliseconds: 400),
                        transitionType: ContainerTransitionType.fade,
                        closedElevation: 0,
                        closedColor: Colors.transparent,
                        openColor: Colors.transparent,
                        middleColor: Colors.transparent,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        closedBuilder: (context, openContainer) => TvSeriesItem(
                          title: movie.name,
                          heroTag: "poster_${movie.id}",
                          imageUrl:
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          rating: movie.voteAverage,
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