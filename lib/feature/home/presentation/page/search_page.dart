import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/search_cubit/search_cubit.dart';
import '../cubit/search_cubit/search_state.dart';
import '../widget/item/trending_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<SearchCubit>().searchMovies(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1527),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF1E293B),
                          hintText: "Movie searching...",
                          hintStyle: const TextStyle(color: Color(0xFF475569)),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Colors.white54,
                          ),
                          suffixIcon: BlocBuilder<SearchCubit, SearchState>(
                            builder: (context, state) {
                              return _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        context
                                            .read<SearchCubit>()
                                            .searchMovies('');
                                      },
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Natijalar
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      // Bo'sh holat
                      if (state is SearchInitial) {
                        return const Center(
                          child: Text(
                            "Kino nomi yozing...",
                            style: TextStyle(color: Colors.white38),
                          ),
                        );
                      }

                      // Loading
                      if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      // Xato
                      if (state is SearchError) {
                        return Center(
                          child: Text(
                            'Xatolik: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      // Natijalar
                      if (state is SearchLoaded) {
                        if (state.movies.isEmpty) {
                          return const Center(
                            child: Text(
                              "Hech narsa topilmadi 🎬",
                              style: TextStyle(color: Colors.white38),
                            ),
                          );
                        }
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: state.movies.length,
                          itemBuilder: (context, index) {
                            final movie = state.movies[index];
                            return TrendingItem(
                              heroTag: "poster_${state.movies[index].id}",
                              title: movie.title,
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              rating: movie.voteAverage,
                              onTap: () {},
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
