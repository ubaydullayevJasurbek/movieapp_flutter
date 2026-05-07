import '../data_source/movie_data_source.dart';
import '../model/movie_response.dart';

class MovieRepository {
  final MovieDataSource _dataSource = MovieDataSource();

  Future<MovieResponse> getMovies() async {
    return await _dataSource.getMovies();
  }
}