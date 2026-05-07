import 'package:go_router/go_router.dart';

import '../../feature/home/presentation/page/home_page.dart';
import '../../feature/splash/presentation/page/splash_page.dart';

abstract class AppRouter {
  static final String init = "/";
  static final String home = "/home";

  static GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(path: init, builder: (context, state) => SplashScreen()),
      GoRoute(path: home,builder: (context,state)=> HomePage())
    ],
  );
}
