import 'package:go_router/go_router.dart';
import 'package:movieapp/feature/details/presentation/pages/movie_details_page.dart';
import 'package:movieapp/feature/main/presentation/page/main_page.dart';
import '../../feature/splash/presentation/page/splash_page.dart';

abstract class AppRouter {
  static final String init = "/";
  static final String home = "/home";
  static final String details = "/details";

  static GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(path: init, builder: (context, state) => const SplashScreen()),
      GoRoute(path: home, builder: (context, state) => const MainPage()),
      GoRoute(
        path: details,
        builder: (context, state) {
          final movieId = state.extra as int;
          return MovieDetailsPage(movieId: movieId);
        },
      ),
    ],
  );
}