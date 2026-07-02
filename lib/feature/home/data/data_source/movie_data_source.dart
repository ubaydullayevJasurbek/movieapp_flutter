import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/feature/home/data/model/now_playing_response/now_playing_response.dart';
import 'package:movieapp/feature/home/data/model/search_response/search_response.dart';
import 'package:movieapp/feature/home/data/model/top_rated_response/top_rated_response.dart';
import 'package:movieapp/feature/home/data/model/tv_series_response/tv_series_response.dart';
import '../../../../core/network/dio_client.dart';
import '../model/move_response/movie_detail_response.dart';
import '../model/move_response/movie_response.dart';

class MovieDataSource {
  final Dio dio = DioClient.instance;

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

  Future<TopRatedResponse> getTopRated() async {
    try {
      final topresponse = await dio.get("/3/movie/top_rated");
      debugPrint("RESPONSE: ${topresponse.data}");
      return TopRatedResponse.fromJson(topresponse.data);
    } on DioException catch (e) {
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Filmlar yuklanmadi:${e.message}");
    }
  }

  Future<NowPlayingResponse> getNowPlay() async {
    try {
      final nowPlayResponse = await dio.get("/3/movie/now_playing");
      debugPrint("RESPONSE: ${nowPlayResponse.data}");
      return NowPlayingResponse.fromJson(nowPlayResponse.data);
    } on DioException catch (e) {
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Filmlar yuklanmadi: ${e.message}");
    }
  }

  Future<TVSeriesResponse> getTVSeries() async {
    try {
      final tvSeriesResponse = await dio.get("/3/tv/on_the_air");
      debugPrint("RESPONSE: ${tvSeriesResponse.data}");
      return TVSeriesResponse.fromJson(tvSeriesResponse.data);
    } on DioException catch (e) {
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Filmlar yuklanmadi: ${e.message}");
    }
  }

  Future<SearchResponse> getSearch(String query) async {
    try {
      final searchResponse = await dio.get(
        "/3/search/movie",
        queryParameters: {'query': query},
      );
      debugPrint("RESPONSE:${searchResponse.data}");
      return SearchResponse.fromJson(searchResponse.data);
    } on DioException catch (e) {
      debugPrint("DIO ERROR:${e.message}");
      throw Exception("Filmlar yuklanmadi:${e.message}");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int movieId) async {
    try {
      final detailResponse = await dio.get("/3/movie/$movieId");
      debugPrint("RESPONSE: ${detailResponse.data}");
      return MovieDetailResponse.fromJson(detailResponse.data);
    } on DioException catch (e) {
      debugPrint("DIO ERROR: ${e.message}");
      throw Exception("Film tafsilotlari yuklanmadi: ${e.message}");
    }
  }
}
