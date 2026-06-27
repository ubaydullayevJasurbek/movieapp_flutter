import 'package:movieapp/feature/details/data/model/cast_model/details_cast_response.dart';
import 'package:movieapp/feature/details/domain/entity/movie_detail.dart';

sealed class DetailsState {
  const DetailsState();
}

class DetailsInitial extends DetailsState {
  const DetailsInitial();
}

class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

class DetailsLoaded extends DetailsState {
  final MovieDetail movie;
  final List<Cast> cast;

  const DetailsLoaded({
    required this.movie,
    this.cast = const [],
  });
}

class DetailsError extends DetailsState {
  final String message;
  const DetailsError(this.message);
}

