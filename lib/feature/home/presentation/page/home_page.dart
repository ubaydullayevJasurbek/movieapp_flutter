import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/movie_cubit/movie_cubit.dart';
import '../cubit/now_playing_cubit/now_playing_cubit.dart';
import '../cubit/top_rated_cubit/top_rated_cubit.dart';
import '../cubit/tv_series_cubit/tv_series_cubit.dart';
import '../widget/home_search_bar/home_search_bar.dart';
import '../widget/section/now_playing_section.dart';
import '../widget/section/top_movies_section.dart';
import '../widget/section/trending_section.dart';
import '../widget/section/tv_series_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieCubit()..getMovies()),
        BlocProvider(create: (_) => TopRatedCubit()..getTopRated()),
        BlocProvider(create: (_) => NowPlayingCubit()..getNowPlaying()),
        BlocProvider(create: (_) => TvSeriesCubit()..getTVSeries()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1527),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomeSearchBar(),
              SizedBox(height: 20),
              TrendingSection(),
              SizedBox(height: 20),
              TopMoviesSection(),
              SizedBox(height: 12),
              TvSeriesSection(),
              SizedBox(height: 12),
              NowPlayingSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}