import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_colors.dart';

import '../../../../details/presentation/pages/movie_details_page.dart';
import '../../../data/model/now_playing_response/now_playing_response.dart';
import '../../cubit/now_playing_cubit/now_playing_cubit.dart';
import '../../cubit/now_playing_cubit/now_playing_state.dart';
import '../item/now_playing_item.dart';
import 'section_skeleton.dart';

class NowPlayingSection extends StatelessWidget {
  const NowPlayingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  color: AppColors.rating,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Recommended For You",
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
        const SizedBox(height: 12),

        BlocBuilder<NowPlayingCubit, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingError) {
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

            final isLoading = state is! NowPlayingLoaded;
            final movies = state is NowPlayingLoaded ? state.movies : _fakeMovies;

            return SectionSkeleton(
              enabled: isLoading,
              child: SizedBox(
                height: 285,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    final imageUrl =
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}";

                    if (isLoading) {
                      return NowPlayingItem(
                        title: movie.title,
                        imageUrl: imageUrl,
                        rating: movie.voteAverage,
                        year: movie.releaseDate.year.toString(),
                        onTap: () {},
                      );
                    }

                    return OpenContainer(
                      closedElevation: 0,
                      openElevation: 0,
                      closedColor: Colors.transparent,
                      openColor: const Color(0xff0B1527),
                      transitionType: ContainerTransitionType.fadeThrough,
                      closedBuilder: (_, openContainer) => NowPlayingItem(
                        title: movie.title,
                        imageUrl: imageUrl,
                        rating: movie.voteAverage,
                        year: movie.releaseDate.year.toString(),
                        onTap: openContainer,
                      ),
                      openBuilder: (_, _) =>
                          MovieDetailsPage(movieId: movie.id),
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
