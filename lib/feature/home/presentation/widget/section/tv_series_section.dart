import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/tv_series_cubit/tv_series_cubit.dart';
import '../../cubit/tv_series_cubit/tv_series_state.dart';
import '../item/tv_series_item.dart';

class TvSeriesSection extends StatelessWidget {
  const TvSeriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "TV Series",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        const SizedBox(height: 12),


        BlocBuilder<TvSeriesCubit, TVSeriesState>(
          builder: (context, state) {
            if (state is TVSeriesLoading) {
              return const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
            if (state is TVSeriesError) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Text(
                    'Xatolik: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            if (state is TVSeriesLoaded) {
              return SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: TvSeriesItem(
                        title: movie.name,
                        imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        rating: movie.voteAverage,
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}