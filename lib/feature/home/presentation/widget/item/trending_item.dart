import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

class TrendingItem extends StatefulWidget {
  final String title;
  final String heroTag;
  final String imageUrl;
  final double rating;
  final int? year;
  final VoidCallback onTap;
  final bool showHero;

  const TrendingItem({
    super.key,
    required this.title,
    required this.heroTag,
    required this.imageUrl,
    required this.rating,
    this.year,
    required this.onTap,
    this.showHero = true,
  });

  @override
  State<TrendingItem> createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final poster = ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 200,
        width: 140,
        color: const Color(0xff1A2333),
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 300),
          placeholder: (c, u) => const SizedBox(),
          errorWidget: (c, u, e) => const Center(
            child: Icon(Icons.movie_outlined, color: Colors.white24, size: 32),
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Poster
              widget.showHero
                  ? Hero(tag: widget.heroTag, child: poster)
                  : poster,

              const SizedBox(height: 8),

              // Title — poster tagida
              Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              // Rating + year
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.rating, size: 13),
                  const SizedBox(width: 3),
                  Text(
                    widget.rating.toStringAsFixed(1),
                    style: TextStyle(
                      color: AppColors.rating,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.year != null) ...[
                    const SizedBox(width: 5),
                    Text(
                      '· ${widget.year}',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
