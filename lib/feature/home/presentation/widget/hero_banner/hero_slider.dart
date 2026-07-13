import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../data/model/move_response/movie_response.dart';
import '../../../data/repository_impl/movie_repository.dart';
import 'hero_indicator.dart';
import 'hero_item.dart';

class HeroSlider extends StatefulWidget {
  final List<Result> movies;

  final Future<void> Function(int)? onWatchNow;

  final MovieRepository? repository;

  const HeroSlider({
    super.key,
    required this.movies,
    this.onWatchNow,
    this.repository,
  });

  @override
  State<HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> {
  Timer? _autoplayTimer;
  int currentIndex = 0;
  bool isMuted = true;
  bool _watchLoading = false;
  late final MovieRepository _repository;

  static const _autoplayDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? MovieRepository();
    _startAutoplay();
  }

  void _startAutoplay() {
    if (widget.movies.length <= 1) return;
    _autoplayTimer?.cancel();
    _autoplayTimer = Timer.periodic(_autoplayDuration, (_) {
      _goToIndex(
        (currentIndex + 1) % widget.movies.length,
        restartTimer: false,
      );
    });
  }

  void _goToIndex(int index, {bool restartTimer = true}) {
    if (!mounted || widget.movies.isEmpty) return;
    setState(() {
      currentIndex = index.clamp(0, widget.movies.length - 1);
    });
    if (restartTimer) _startAutoplay();
  }

  void _onSwipe(DragEndDetails details) {
    if (widget.movies.length <= 1) return;
    final velocity = details.primaryVelocity ?? 0;
    if (velocity < 0) {
      _goToIndex((currentIndex + 1) % widget.movies.length);
    } else if (velocity > 0) {
      _goToIndex(
        (currentIndex - 1 + widget.movies.length) % widget.movies.length,
      );
    }
  }

  @override
  void dispose() {
    _autoplayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Filmlar topilmadi',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    // Balandlikni ekran o'lchamiga moslab olamiz (kichik/katta ekranlar uchun).
    final screenHeight = MediaQuery.of(context).size.height;
    final sliderHeight = (screenHeight * 0.78).clamp(480.0, 700.0);

    return SizedBox(
      height: sliderHeight,
      child: GestureDetector(
        onHorizontalDragEnd: _onSwipe,
        child: Stack(
          children: [
            // Barcha slaydlar ustma-ust turadi, faqat faoli ko'rinadi (fade)
            for (int i = 0; i < widget.movies.length; i++)
              AnimatedOpacity(
                opacity: i == currentIndex ? 1 : 0,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOut,
                child: IgnorePointer(
                  ignoring: i != currentIndex,
                  child: HeroItem(
                    movie: widget.movies[i],
                    isActive: i == currentIndex,
                    repository: _repository,
                  ),
                ),
              ),

            // Top bar — statik
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xffFFD054),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'LUMINA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _glassIcon(Icons.search, semanticLabel: 'Qidiruv'),
                      const SizedBox(width: 10),
                      _glassIcon(
                        Icons.notifications_none,
                        semanticLabel: 'Bildirishnomalar',
                      ),
                      const SizedBox(width: 10),
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tugmalar qatori
            Positioned(
              left: 24,
              right: 24,
              bottom: 60,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xffFFD054,
                          ).withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: _watchLoading
                          ? null
                          : () async {
                              final movieId = widget.movies[currentIndex].id;
                              if (widget.onWatchNow == null) {
                                debugPrint(
                                  'Watch Now bosildi, movieId: $movieId',
                                );
                                return;
                              }
                              setState(() => _watchLoading = true);
                              try {
                                await widget.onWatchNow!(movieId);
                              } finally {
                                if (mounted) {
                                  setState(() => _watchLoading = false);
                                }
                              }
                            },
                      icon: _watchLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ),
                            )
                          : const Icon(Icons.play_arrow, color: Colors.black),
                      label: const Text(
                        'Watch Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFFD054),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: "Mening ro'yxatim"ga qo'shish logikasi
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'My List',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => setState(() => isMuted = !isMuted),
                    child: _glassIcon(
                      isMuted ? Icons.volume_off : Icons.volume_up,
                      semanticLabel: isMuted
                          ? 'Ovozni yoqish'
                          : 'Ovozni o\'chirish',
                    ),
                  ),
                ],
              ),
            ),

            // Indikator — endi bosish orqali ham slayd almashadi
            Positioned(
              left: 28,
              bottom: 24,
              child: HeroIndicator(
                currentIndex: currentIndex,
                count: widget.movies.length,
                onTap: (index) => _goToIndex(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassIcon(IconData icon, {String? semanticLabel}) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}
