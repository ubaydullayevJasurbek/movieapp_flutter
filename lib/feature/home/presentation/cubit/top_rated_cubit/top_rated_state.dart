import 'package:movieapp/feature/home/data/model/top_rated_response/top_rated_response.dart';

abstract class TopRatedState {}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedLoaded extends TopRatedState {

  final List<Result> movies;

  TopRatedLoaded(this.movies);
}

class TopRatedError extends TopRatedState {

  final String message;

  TopRatedError(this.message);
}