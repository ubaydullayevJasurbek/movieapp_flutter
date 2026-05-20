import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Now Playing",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: List.generate(
                    state.movies.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: NowPlayingItem(
                        title: state.movies[index].title,
                        imageUrl:
                        'https://image.tmdb.org/t/p/w500${state.movies[index].posterPath}',
                        overview: state.movies[index].overview,
                      ),
                    ),
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