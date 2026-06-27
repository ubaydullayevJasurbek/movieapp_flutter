import 'package:fpdart/fpdart.dart';
import 'package:movieapp/core/error/failure.dart';
import 'package:movieapp/feature/details/data/model/cast_model/details_cast_response.dart';
import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';

abstract interface class DetailsRepository {
  Future<Either<Failure, MovieDetail>> getDetails(int movieId);
  Future<Either<Failure, DetailsCastResponse>> getCastMovie(int movieId);
}

