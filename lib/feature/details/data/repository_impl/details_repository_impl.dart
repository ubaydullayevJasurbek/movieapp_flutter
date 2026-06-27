import 'package:fpdart/fpdart.dart';
import 'package:movieapp/core/error/failure.dart';
import 'package:movieapp/feature/details/data/model/cast_model/details_cast_response.dart';
import 'package:movieapp/feature/details/data/model/movie_detail_model.dart';
import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';
import 'package:movieapp/feature/details/domain/repository/details_repository.dart';

import '../data_source/details_data_source.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteDataSource _remoteDataSource;

  const DetailsRepositoryImpl({
    required DetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, MovieDetail>> getDetails(int movieId) async {
    try {
      final response = await _remoteDataSource.getMovieDetail(movieId);
      return Right(response.toEntity());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, DetailsCastResponse>> getCastMovie(int movieId) async {
    try {
      final response = await _remoteDataSource.getCastMovie(movieId);
      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}