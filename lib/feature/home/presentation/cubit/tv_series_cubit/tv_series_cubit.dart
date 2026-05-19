
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/feature/home/data/repository_impl/movie_repository.dart';
import 'package:movieapp/feature/home/presentation/cubit/tv_series_cubit/tv_series_state.dart';


class TvSeriesCubit extends Cubit<TVSeriesState> {
  final MovieRepository _repository =  MovieRepository();

  TvSeriesCubit() : super(TVSeriesInitial());

  Future<void> getTVSeries() async{
    emit(TVSeriesLoading());
    try{
      final response = await _repository.getTVSeries();
      emit(TVSeriesLoaded(response.results));
    }catch (e){
      emit(TVSeriesError(e.toString()));
    }
  }
}
