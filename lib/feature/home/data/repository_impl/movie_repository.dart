import 'package:movieapp/feature/home/data/model/now_playing_response/now_playing_response.dart';
import 'package:movieapp/feature/home/data/model/top_rated_response/top_rated_response.dart';

import '../data_source/movie_data_source.dart';
import '../model/move_response/movie_response.dart';

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
}