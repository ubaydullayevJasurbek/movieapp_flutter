import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieapp/feature/home/data/model/now_playing_response/now_playing_response.dart';
import 'package:movieapp/feature/home/data/model/top_rated_response/top_rated_response.dart';
import 'package:movieapp/feature/home/data/model/tv_series_response/tv_series_response.dart';
import '../model/move_response/movie_response.dart';

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
  
  Future<TopRatedResponse> getTopRated() async{
    try{
      final topresponse =await dio.get("/3/movie/top_rated");
      debugPrint("RESPONSE: ${topresponse.data}");
      return TopRatedResponse.fromJson(topresponse.data);
    } on DioException catch(e){
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Filmlar yuklanmadi:${e.message}");
    }
  }

  
  Future<NowPlayingResponse> getNowPlay() async{
    try{
      final nowPlayResponse = await dio.get("/3/movie/now_playing");
      debugPrint("RESPONSE: ${nowPlayResponse.data}");
      return NowPlayingResponse.fromJson(nowPlayResponse.data);
    }  on DioException catch(e){
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Filmlar yuklanmadi: ${e.message}");
    }
  }
  
  Future<TVSeriesResponse> getTVSeries() async{
    try{
      final tvSeriesResponse = await dio.get("/3/tv/on_the_air");
      debugPrint("RESPONSE: ${tvSeriesResponse.data}");
      return TVSeriesResponse.fromJson(tvSeriesResponse.data);
    } on DioException catch(e){
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Filmlar yuklanmadi: ${e.message}");
    }
  }

}