import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/di/injection.dart';
import 'package:movieapp/feature/details/presentation/cubit/details_cubit.dart';
import 'package:movieapp/feature/details/presentation/cubit/details_state.dart';
import 'package:movieapp/feature/details/presentation/widget/detail_header.dart';
import 'package:movieapp/feature/details/presentation/widget/movi_card.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injection.detailsCubit..loadMovieDetail(movieId),

      child: Scaffold(
        backgroundColor: const Color(0xff08111F),
        body: SafeArea(
          child: BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoading || state is DetailsInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DetailsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }

              if (state is DetailsLoaded) {
                final movie = state.movie;

                return SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      /// HEADER
                      DetailHeader(
                        backdropUrl: movie.backdropPath != null
                            ? "https://image.tmdb.org/t/p/original${movie.backdropPath}"
                            : null,
                        onBack: () => Navigator.pop(context),
                        onBookmark: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Bookmarkga qo'shildi!!!"),
                            ),
                          );
                        },
                        onShare: () {
                          Share.share(
                            "Ushbu filmni tomosha qiling: ${movie.title}",
                          );
                        },
                      ),

                      /// MOVIE CARD
                      Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: MovieInfoCard(movie: movie),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
