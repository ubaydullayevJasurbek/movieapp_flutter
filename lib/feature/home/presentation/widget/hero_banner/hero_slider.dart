import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../data/model/move_response/movie_response.dart';
import 'hero_indicator.dart';
import 'hero_item.dart';

class HeroSlider extends StatefulWidget {
  final List<Result> movies;

  const HeroSlider({super.key, required this.movies});

  @override
  State<HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> {
  Timer? _autoplayTimer;
  int currentIndex = 0;
  bool isMuted = true;

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  void _startAutoplay() {
    _autoplayTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        currentIndex = (currentIndex + 1) % widget.movies.length;
      });
    });
  }

  @override
  void dispose() {
    _autoplayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
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
                    _glassIcon(Icons.search),
                    const SizedBox(width: 10),
                    _glassIcon(Icons.notifications_none),
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
                        color: const Color(0xffFFD054).withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final movieId = widget.movies[currentIndex].id;
                      // TODO: navigate to detail / play screen using movieId
                      debugPrint('Watch Now bosildi, movieId: $movieId');
                    },
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
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
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'My List',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassIcon(IconData icon) {
    return ClipRRect(
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
    );
  }
}
