import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/feature/category/category_page.dart';
import 'package:movieapp/feature/favourite/favourite_page.dart';
import 'package:movieapp/feature/profile/profile_page.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';
import '../widget/trending_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieCubit()..getMovies(),
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
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  bool _hasText = false;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  // Home sahifasining asosiy kontenti
  Widget _buildHomeContent() {
    return Column(
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
                    icon:
                    const Icon(Icons.clear, color: Colors.white),
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

        // BlocBuilder — holatga qarab UI ko'rsatadi
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      SingleChildScrollView(child: _buildHomeContent()),
      const CategoryPage(),
      const FavouritePage(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Book",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
        ],

        onTap: _navigateBottomBar,
      ),
    );
  }
}