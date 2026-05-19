

import 'package:movieapp/feature/home/data/model/tv_series_response/tv_series_response.dart';

abstract class TVSeriesState {}

class TVSeriesInitial extends TVSeriesState {}

class TVSeriesLoading extends TVSeriesState{}

class TVSeriesLoaded extends TVSeriesState{
  final List<Result> movies;

  TVSeriesLoaded(this.movies);
}

class TVSeriesError extends TVSeriesState{
  final String message;
  TVSeriesError(this.message);

}
