import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/feature/details/domain/get_case_use/get_cast_use_case.dart';
import 'package:movieapp/feature/details/presentation/cubit/details_state.dart';
import '../../domain/get_case_use/get_movie_details_use_case.dart';

final class DetailsCubit extends Cubit<DetailsState> {
  final GetMovieDetailUseCase _getMovieDetail;
  final GetCastUseCase _getCastUseCase;

  DetailsCubit({
    required GetMovieDetailUseCase getMovieDetail,
    required GetCastUseCase getCastUseCase,
  })  : _getMovieDetail = getMovieDetail,
        _getCastUseCase = getCastUseCase,
        super(const DetailsInitial());

  Future<void> getMovieDetail(int movieId) async {
    if (isClosed) return;
    emit(const DetailsLoading());

    final result = await _getMovieDetail(movieId);

    if (isClosed) return;
    result.fold(
          (failure) => emit(DetailsError(failure.message)),
          (movie) => emit(DetailsLoaded(movie: movie)),
    );
  }

  Future<void> loadMovieDetail(int movieId) async {
    if (isClosed) return;
    emit(const DetailsLoading());

    final result = await _getMovieDetail(movieId);

    if (isClosed) return;
    result.fold(
          (failure) => emit(DetailsError(failure.message)),
          (movie) async {
        emit(DetailsLoaded(movie: movie));

        final castResult = await _getCastUseCase(movieId);
        if (isClosed) return;
        castResult.fold(
              (failure) => emit(DetailsError(failure.message)),
              (castResponse) {
            emit(DetailsLoaded(
              movie: movie,
              cast: castResponse.cast,
            ));
          },
        );
      },
    );
  }
}