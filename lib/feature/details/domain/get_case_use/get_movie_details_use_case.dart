import 'package:fpdart/fpdart.dart';
import 'package:movieapp/core/error/failure.dart';
import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';
import 'package:movieapp/feature/details/domain/repository/details_repository.dart';

final class GetMovieDetailUseCase {
  final DetailsRepository _repository;

  const GetMovieDetailUseCase({required DetailsRepository repository})
      : _repository = repository;

  Future<Either<Failure, MovieDetail>> call(int movieId) =>
      _repository.getDetails(movieId);
}