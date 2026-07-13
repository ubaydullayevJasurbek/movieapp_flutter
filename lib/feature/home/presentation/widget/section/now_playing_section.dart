import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../details/presentation/pages/movie_details_page.dart';
import '../../cubit/now_playing_cubit/now_playing_cubit.dart';
import '../../cubit/now_playing_cubit/now_playing_state.dart';
import '../item/now_playing_item.dart';

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
              children: const [
                Icon(
                  Icons.access_time_outlined,
                  color: Color(0xffFFD054),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "Recommended For You",
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
        const SizedBox(height: 12),

        BlocBuilder<NowPlayingCubit, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingLoading) {
              return const SizedBox(
                height: 210,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
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
            if (state is NowPlayingLoaded) {
              return SizedBox(
                height: 285,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];

                    return OpenContainer(
                      closedElevation: 0,
                      openElevation: 0,
                      closedColor: Colors.transparent,
                      openColor: const Color(0xff0B1527),
                      transitionType: ContainerTransitionType.fadeThrough,
                      closedBuilder: (_, openContainer) => NowPlayingItem(
                        title: movie.title,
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        rating: movie.voteAverage,
                        year: movie.releaseDate.year.toString(),
                        onTap: openContainer,
                      ),
                      openBuilder: (_, __) =>
                          MovieDetailsPage(movieId: movie.id),
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
