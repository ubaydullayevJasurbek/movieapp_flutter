import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

import '../../../data/model/move_response/movie_detail_response.dart';
import '../../../data/model/move_response/movie_response.dart';
import '../../../data/repository_impl/movie_repository.dart';

class HeroItem extends StatefulWidget {
  final Result movie;
  final bool isActive;

  final MovieRepository repository;

  const HeroItem({
    super.key,
    required this.movie,
    required this.isActive,
    required this.repository,
  });

  @override
  State<HeroItem> createState() => _HeroItemState();
}

class _HeroItemState extends State<HeroItem>
    with SingleTickerProviderStateMixin {
  Future<MovieDetailResponse>? _detailFuture;

  late final AnimationController _kenBurnsController;
  late final Animation<double> _kenBurnsAnimation;

  @override
  void initState() {
    super.initState();

    _kenBurnsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _kenBurnsAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _kenBurnsController, curve: Curves.easeInOut),
    );

    if (widget.isActive) {
      _kenBurnsController.repeat(reverse: true);
      _loadDetailIfNeeded();
    }
  }

  /// Detallarni faqat slayd birinchi marta faol bo'lganda yuklaydi.
  /// Shu tufayli sahifa ochilganda barcha 5 ta film uchun emas,
  /// faqat foydalanuvchi ko'radigan filmlar uchun so'rov ketadi.
  void _loadDetailIfNeeded() {
    _detailFuture ??= widget.repository.getMovieDetail(widget.movie.id);
  }

  @override
  void didUpdateWidget(covariant HeroItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !oldWidget.isActive) {
      _kenBurnsController.repeat(reverse: true);
      _loadDetailIfNeeded();
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
                  ? CachedNetworkImage(
                      imageUrl: backdropUrl,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: (context, url) =>
                          ColoredBox(color: AppColors.surfaceHigh),
                      errorWidget: (context, url, error) =>
                          ColoredBox(color: AppColors.surfaceHigh),
                    )
                  : Container(color: AppColors.surfaceHigh),
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(gradient: AppColors.heroScrim),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.4, -0.7),
              radius: 1.1,
              colors: [
                AppColors.heroAccent.withValues(alpha: 0.10),
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
                          runSpacing: 8,
                          children: detail.genres
                              .take(3)
                              .map((g) => _genreChip(g.name))
                              .toList(),
                        ),
                      const SizedBox(height: 18),
                      Text(
                        widget.movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.onScrim,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                          letterSpacing: -0.5,
                          shadows: [
                            Shadow(
                              color: AppColors.onScrimShadow,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.onScrimMuted,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.heroAccent,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.movie.voteAverage.toStringAsFixed(1)} IMDb',
                            style: const TextStyle(
                              color: AppColors.onScrim,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '|',
                            style: TextStyle(
                              color: AppColors.onScrim.withValues(alpha: 0.38),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${widget.movie.releaseDate?.year}',
                            style: const TextStyle(
                              color: AppColors.onScrimMuted,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (detail != null &&
                              detail.runtimeLabel.isNotEmpty) ...[
                            const SizedBox(width: 14),
                            const Icon(
                              Icons.access_time,
                              color: AppColors.onScrimMuted,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              detail.runtimeLabel,
                              style: const TextStyle(
                                color: AppColors.onScrimMuted,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
            color: AppColors.onScrim.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.onScrim.withValues(alpha: 0.15),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.onScrim,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
