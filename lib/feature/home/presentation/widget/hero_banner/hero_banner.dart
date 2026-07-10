import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp/core/router/app_router.dart';

import '../../cubit/movie_cubit/movie_cubit.dart';
import '../../cubit/movie_cubit/movie_state.dart';
import '../../../data/model/move_response/movie_response.dart';
import 'hero_slider.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const SizedBox(
            height: 620,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is MovieLoaded) {
          final List<Result> movies = state.movies.take(5).toList();

          if (movies.isEmpty) {
            return const SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  'Hozircha filmlar mavjud emas',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            );
          }

          return HeroSlider(
            movies: movies,
            onWatchNow: (movieId) {
              context.push(AppRouter.details, extra: movieId);
            },
          );
        }

        if (state is MovieError) {
          return SizedBox(
            height: 620,
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
