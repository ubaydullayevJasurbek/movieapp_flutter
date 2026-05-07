import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieapp/feature/home/data/data_source/movie_data_source.dart';

import 'core/router/app_router.dart';

void main()  async{
  await dotenv.load(fileName:  ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await MovieDataSource().getMovies();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.goRouter,
    );
  }
}
