import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieapp/feature/favourite/favourite_injection.dart';
import 'package:movieapp/feature/home/data/data_source/movie_data_source.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName:  ".env");
  await setupFavourites();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark
    )
  );

  runApp(const MyApp());
  await MovieDataSource().getMovies();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.goRouter,
    );
  }
}
