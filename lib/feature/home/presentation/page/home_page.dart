import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/core/theme/theme_cubit.dart';
import 'package:movieapp/feature/home/presentation/widget/hero_banner/hero_banner.dart';

import '../cubit/movie_cubit/movie_cubit.dart';
import '../cubit/now_playing_cubit/now_playing_cubit.dart';
import '../cubit/top_rated_cubit/top_rated_cubit.dart';
import '../cubit/tv_series_cubit/tv_series_cubit.dart';
import '../widget/section/now_playing_section.dart';
import '../widget/section/top_movies_section.dart';
import '../widget/section/trending_section.dart';
import '../widget/section/tv_series_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.onSearchTap});

  /// Switches the [MainPage] bottom navigation to the Search tab. Wired to the
  /// search affordances on Home so they act as shortcuts (no route is pushed).
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    // Rebuild in place on theme changes so the AppColors tokens re-resolve.
    context.watch<ThemeCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MovieCubit()..getMovies()),
          BlocProvider(create: (_) => TopRatedCubit()..getTopRated()),
          BlocProvider(create: (_) => NowPlayingCubit()..getNowPlaying()),
          BlocProvider(create: (_) => TvSeriesCubit()..getTVSeries()),
        ],
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(
              scrollbars: false,
              overscroll: false,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroBanner(onSearchTap: onSearchTap),
                  const SizedBox(height: 20),
                  const TrendingSection(),
                  const SizedBox(height: 20),
                  const TopMoviesSection(),
                  const SizedBox(height: 12),
                  const TvSeriesSection(),
                  const SizedBox(height: 12),
                  const NowPlayingSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
