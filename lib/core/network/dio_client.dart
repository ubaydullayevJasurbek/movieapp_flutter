import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= Dio(
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
    return _instance!;
  }
}
