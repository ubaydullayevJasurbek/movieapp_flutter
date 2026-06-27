import 'package:dio/dio.dart';
import 'package:movieapp/feature/details/data/model/cast_model/details_cast_response.dart';
import 'package:movieapp/feature/details/data/model/details_response/details_response.dart';

abstract interface class DetailsRemoteDataSource {
  Future<DetailsResponse> getMovieDetail(int movieId);
  Future<DetailsCastResponse> getCastMovie(int movieId);
}

class DetailsRemoteDataSourceImpl implements DetailsRemoteDataSource {
  final Dio _dio;

  const DetailsRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<DetailsResponse> getMovieDetail(int movieId) async {
    final response = await _dio.get('/3/movie/$movieId');
    return DetailsResponse.fromJson(response.data);
  }
  
  @override
  Future<DetailsCastResponse> getCastMovie(int movieId) async{
    final response = await _dio.get('/3/movie/$movieId/credits');
    return DetailsCastResponse.fromJson(response.data);
  }
}