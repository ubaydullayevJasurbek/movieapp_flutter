import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../data/model/move_response/movie_detail_response.dart';
import '../../../data/model/move_response/movie_response.dart';
import '../../../data/repository_impl/movie_repository.dart';

class HeroItem extends StatefulWidget {
  final Result movie;
  final bool isActive;

  const HeroItem({super.key, required this.movie, required this.isActive});

  @override
  State<HeroItem> createState() => _HeroItemState();
}

class _HeroItemState extends State<HeroItem>
    with SingleTickerProviderStateMixin {
  final MovieRepository _repository = MovieRepository();
  late final Future<MovieDetailResponse> _detailFuture;

  late final AnimationController _kenBurnsController;
  late final Animation<double> _kenBurnsAnimation;

  @override
  void initState() {
    super.initState();
    _detailFuture = _repository.getMovieDetail(widget.movie.id);

    _kenBurnsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _kenBurnsAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _kenBurnsController, curve: Curves.easeInOut),
    );

    if (widget.isActive) _kenBurnsController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant HeroItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !oldWidget.isActive) {
      _kenBurnsController.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _kenBurnsController.stop();
    }
  }

  @override
  void dispose() {
    _kenBurnsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backdropUrl = widget.movie.backdropPath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/original${widget.movie.backdropPath}'
        : null;

    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: 'movie-backdrop-${widget.movie.id}',
          child: ClipRect(
            child: AnimatedBuilder(
              animation: _kenBurnsAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _kenBurnsAnimation.value,
                  child: child,
                );
              },
              child: backdropUrl != null
                  ? Image.network(
                      backdropUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, builder) =>
                          Container(color: Colors.black),
                    )
                  : Container(color: Colors.black),
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.55),
                Colors.black.withValues(alpha: 0.95),
              ],
              stops: const [0.25, 0.7, 1.0],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.4, -0.7),
              radius: 1.1,
              colors: [
                const Color(0xffFFD054).withValues(alpha: 0.10),
                Colors.transparent,
              ],
            ),
          ),
        ),

        Positioned(
          left: 24,
          right: 24,
          bottom: 140,
          child: AnimatedOpacity(
            opacity: widget.isActive ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            child: AnimatedSlide(
              offset: widget.isActive ? Offset.zero : const Offset(0, 0.06),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              child: FutureBuilder<MovieDetailResponse>(
                future: _detailFuture,
                builder: (context, snapshot) {
                  final detail = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (detail != null && detail.genres.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          children: detail.genres
                              .take(3)
                              .map((g) => _genreChip(g.name))
                              .toList(),
                        ),
                      const SizedBox(height: 14),
                      Text(
                        widget.movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xffFFD054),
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.movie.voteAverage.toStringAsFixed(1)} IMDb',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '|',
                            style: TextStyle(color: Colors.white38),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${widget.movie.releaseDate.year}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          if (detail != null &&
                              detail.runtimeLabel.isNotEmpty) ...[
                            const SizedBox(width: 14),
                            const Icon(
                              Icons.access_time,
                              color: Colors.white70,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              detail.runtimeLabel,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _genreChip(String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
