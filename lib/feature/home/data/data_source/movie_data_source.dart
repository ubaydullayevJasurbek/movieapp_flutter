import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/movie_response.dart';

class MovieDataSource {
  late final Dio dio;

  MovieDataSource() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.themoviedb.org",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        receiveDataWhenStatusError: true,
        headers: {
          "Authorization": "Bearer ${dotenv.env['TMDB_TOKEN'] ?? ''}",
          "Content-Type": "application/json",
        },
      ),
    );
  }

  Future<MovieResponse> getMovies() async {
    try {
      final response = await dio.get("/3/movie/now_playing");
      debugPrint("RESPONSE: ${response.data}");
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Filmlar yuklanmadi: ${e.message}");
    }
  }
}