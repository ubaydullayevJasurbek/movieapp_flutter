import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/feature/home/presentation/cubit/now_playing_cubit/now_playing_cubit.dart';
import 'package:movieapp/feature/home/presentation/cubit/top_rated_cubit/top_rated_cubit.dart';
import 'package:movieapp/feature/home/presentation/cubit/top_rated_cubit/top_rated_state.dart';
import 'package:movieapp/feature/home/presentation/widget/now_playing_item.dart';
import 'package:movieapp/feature/home/presentation/widget/top_rated_slider.dart';
import '../cubit/movie_cubit/movie_cubit.dart';
import '../cubit/movie_cubit/movie_state.dart';
import '../cubit/now_playing_cubit/now_playing_state.dart';
import '../widget/trending_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieCubit()..getMovies()),
        BlocProvider(create: (_) => TopRatedCubit()..getTopRated()),
        BlocProvider(create: (_) => NowPlayingCubit()..getNowPlaying()),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _hasText = _searchController.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 72, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Good evening",
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "What would you\nlike to watch?",
                  style: GoogleFonts.aBeeZee(
                    color: const Color(0xFFF1F5F9),
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1E293B),
                    hintText: "Movie searching...",
                    hintStyle: const TextStyle(color: Color(0xFF475569)),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    suffixIcon: _hasText
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Trending Movies",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Trending Movies
          BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }
              if (state is MovieError) {
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
              if (state is MovieLoaded) {
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: TrendingItem(
                          title: state.movies[index].title,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${state.movies[index].posterPath}',
                          rating: state.movies[index].voteAverage,
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Top Rated",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          const SizedBox(height: 12),

          // Top Rated
          BlocBuilder<TopRatedCubit, TopRatedState>(
            builder: (context, state) {
              if (state is TopRatedLoading) {
                return const SizedBox(
                  height: 230,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }
              if (state is TopRatedError) {
                return SizedBox(
                  height: 230,
                  child: Center(
                    child: Text(
                      "Xatolik: ${state.message}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }
              if (state is TopRatedLoaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 230,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.12,
                    viewportFraction: 0.80,
                    clipBehavior: Clip.none,
                  ),
                  items: state.movies.map((movie) {
                    return TopRatedSlider(
                      title: movie.title,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      rating: movie.voteAverage,
                    );
                  }).toList(),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          const SizedBox(height: 12),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Now Playing",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          const SizedBox(height: 20),
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

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: _buildHomeContent(),
    );
  }
}
