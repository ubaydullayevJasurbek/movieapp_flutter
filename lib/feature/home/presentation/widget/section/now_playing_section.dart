import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../details/presentation/pages/movie_details_page.dart';
import '../../cubit/now_playing_cubit/now_playing_cubit.dart';
import '../../cubit/now_playing_cubit/now_playing_state.dart';
import '../item/now_playing_item.dart';

class NowPlayingSection extends StatelessWidget{
  const NowPlayingSection({super.key});

  @override
  Widget build(BuildContext context) {

    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Now Playing",
                style: TextStyle(color: Colors.white, fontSize: 20),
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
            const SizedBox(width: 14),
          ],
        ),
        const SizedBox(height: 12),


        BlocBuilder<NowPlayingCubit, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingLoading) {
              return const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
            if (state is NowPlayingError) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Text(
                    'Xatolik: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            if (state is NowPlayingLoaded) {
              return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: List.generate(
                    state.movies.length,
                        (index) {
                      final movie = state.movies[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: OpenContainer(
                          transitionDuration: const Duration(milliseconds: 400),
                          transitionType: ContainerTransitionType.fade,
                          closedElevation: 0,
                          closedColor: Colors.transparent,
                          openColor: Colors.transparent,
                          middleColor: Colors.transparent,
                          closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          closedBuilder: (context, openContainer) => NowPlayingItem(
                            title: movie.title,
                            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            overview: movie.overview,
                            onTap: openContainer,
                          ),
                          openBuilder: (context, closeContainer) => MovieDetailsPage(
                            movieId: movie.id,
                          ),
                        ),
                      );
                    },
                  ),
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