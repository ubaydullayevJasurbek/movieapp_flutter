import 'package:fpdart/fpdart.dart';
import 'package:movieapp/feature/details/data/model/cast_model/details_cast_response.dart';
import 'package:movieapp/feature/details/domain/repository/details_repository.dart';
import '../../../../core/error/failure.dart';

class GetCastUseCase {
  final DetailsRepository _repository;

  GetCastUseCase(this._repository);

  Future<Either<Failure, DetailsCastResponse>> call(int movieId) {
    return _repository.getCastMovie(movieId);
  }
}