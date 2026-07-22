import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieapp/feature/favourite/favourite_injection.dart';
import 'package:movieapp/feature/home/data/data_source/movie_data_source.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/theme/theme_local_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupFavourites();

  // Restore the saved theme; fall back to the system setting on first launch.
  final savedMode = await ThemeLocalDataSource().load();
  final themeCubit = ThemeCubit(
    initialMode: savedMode ?? ThemeMode.system,
    systemBrightness:
        WidgetsBinding.instance.platformDispatcher.platformBrightness,
  );

  runApp(MyApp(themeCubit: themeCubit));
  await MovieDataSource().getMovies();
}

class MyApp extends StatefulWidget {
  final ThemeCubit themeCubit;

  const MyApp({super.key, required this.themeCubit});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    // Keep ThemeMode.system reactive to OS changes while the app is running.
    widget.themeCubit.updateSystemBrightness(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final brightness = state.effectiveBrightness;
          _applyStatusBar(brightness);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.resolve(brightness),
            routerConfig: AppRouter.goRouter,
          );
        },
      ),
    );
  }

  void _applyStatusBar(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
