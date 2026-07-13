import 'package:movieapp/feature/home/data/model/now_playing_response/now_playing_response.dart';
import 'package:movieapp/feature/home/data/model/search_response/search_response.dart';
import 'package:movieapp/feature/home/data/model/top_rated_response/top_rated_response.dart';
import 'package:movieapp/feature/home/data/model/tv_series_response/tv_series_response.dart';

import '../data_source/movie_data_source.dart';
import '../model/move_response/movie_detail_response.dart';
import '../model/move_response/movie_response.dart';
import '../model/videos_response/videos_response.dart';

class MovieRepository {
  final MovieDataSource _dataSource = MovieDataSource();

  Future<MovieResponse> getMovies() async {
    return await _dataSource.getMovies();
  }

  Future<TopRatedResponse> getTopRated() async{
    return await _dataSource.getTopRated();
  }

  Future<NowPlayingResponse> getNowPlay()async{
    return await _dataSource.getNowPlay();
  }

  Future<TVSeriesResponse> getTVSeries() async{
    return await _dataSource.getTVSeries();
  }

  Future<SearchResponse> getSearch(String query) async{
    return await _dataSource.getSearch(query);
  }

  Future<MovieDetailResponse> getMovieDetail(int movieId) async {
    return await _dataSource.getMovieDetail(movieId);
  }

  Future<VideosResponse> getVideos(int movieId) async {
    return await _dataSource.getVideos(movieId);
  }
}