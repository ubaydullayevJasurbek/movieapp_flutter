import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopRatedSlider extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final String? genre;
  final int? year;
  final VoidCallback onTap;

  const TopRatedSlider({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.genre,
    required this.year,
    required this.onTap,
  });

  @override
  State<TopRatedSlider> createState() => _TopRatedSliderState();
}

class _TopRatedSliderState extends State<TopRatedSlider> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final meta = [
      if (widget.genre != null) widget.genre!.toUpperCase(),
      if (widget.year != null) widget.year.toString(),
    ].join(' · ');

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Poster ───────────────────────────────
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: _isPressed ? 0.2 : 0.4,
                      ),
                      blurRadius: _isPressed ? 10 : 20,
                      offset: Offset(0, _isPressed ? 4 : 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: (c, u) =>
                        const ColoredBox(color: Color(0xFF1A1D27)),
                        errorWidget: (c, u, e) => const ColoredBox(
                          color: Color(0xFF1A1D27),
                          child: Icon(
                            Icons.broken_image_rounded,
                            color: Colors.white24,
                            size: 36,
                          ),
                        ),
                      ),

                      // Cinematic lighting
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: const Alignment(-0.6, -0.8),
                              radius: 1.0,
                              colors: [
                                const Color(0xffFFD054).withValues(alpha: 0.08),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Rating badge
                      Positioned(
                        top: 10,
                        right: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.13),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.22),
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 11,
                                    color: Color(0xffFFD054),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    widget.rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ── Meta + Title (markazda) ───────────────
            if (meta.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  meta,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xffFFD054),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ),

            Text(
              widget.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                height: 1.2,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}