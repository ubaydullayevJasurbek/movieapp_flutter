import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/movie_cubit/movie_cubit.dart';
import '../../cubit/movie_cubit/movie_state.dart';
import '../../../data/model/move_response/movie_response.dart';
import '../../../data/model/videos_response/videos_response.dart';
import '../../../data/repository_impl/movie_repository.dart';
import '../youtube_triller/trailer_page.dart';
import 'hero_slider.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  Future<void> _openTrailer(BuildContext context, int movieId) async {
    try {
      final videos = await MovieRepository().getVideos(movieId);
      final trailer = _pickTrailer(videos.results);

      if (!context.mounted) return;

      if (trailer == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Treyler topilmadi')),
        );
        return;
      }

      Navigator.of(context).push(
        _trailerRoute('https://www.youtube.com/watch?v=${trailer.key}'),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Treyler yuklanmadi')),
      );
    }
  }

  /// Treylerni ochishda silliq fade + kattalashish animatsiyasi.
  Route<void> _trailerRoute(String videoUrl) {
    return PageRouteBuilder<void>(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 450),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => TrailerPage(videoUrl: videoUrl),
      transitionsBuilder: (_, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  /// YouTube treylerini tanlaydi: avval "Trailer" turini, bo'lmasa
  /// birinchi YouTube videosini qaytaradi.
  VideosResult? _pickTrailer(List<VideosResult> results) {
    final youtube = results.where((v) => v.site == 'YouTube').toList();
    if (youtube.isEmpty) return null;
    return youtube.firstWhere(
      (v) => v.type == 'Trailer',
      orElse: () => youtube.first,
    );
  }

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
            onWatchNow: (movieId) => _openTrailer(context, movieId),
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
