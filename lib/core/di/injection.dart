import 'package:movieapp/core/network/dio_client.dart';
import 'package:movieapp/feature/details/data/data_source/details_data_source.dart';
import 'package:movieapp/feature/details/data/repository_impl/details_repository_impl.dart';
import 'package:movieapp/feature/details/domain/get_case_use/get_cast_use_case.dart';
import 'package:movieapp/feature/details/domain/repository/details_repository.dart';
import 'package:movieapp/feature/details/domain/get_case_use/get_movie_details_use_case.dart';
import 'package:movieapp/feature/details/presentation/cubit/details_cubit.dart';

class Injection {
  static DetailsRepository get _detailsRepository => DetailsRepositoryImpl(
    remoteDataSource: DetailsRemoteDataSourceImpl(
      dio: DioClient.instance,
    ),
  );

  static DetailsCubit get detailsCubit => DetailsCubit(
    getMovieDetail: GetMovieDetailUseCase(
      repository: _detailsRepository,
    ),
    getCastUseCase: GetCastUseCase(_detailsRepository),
  );
}