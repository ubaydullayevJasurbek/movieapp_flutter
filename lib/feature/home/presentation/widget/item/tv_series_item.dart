import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

class TvSeriesItem extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final String year;
  final VoidCallback onTap;
  final String heroTag;
  final bool showHero;

  const TvSeriesItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.year,
    required this.onTap,
    required this.heroTag,
    this.showHero = true,
  });

  @override
  State<TvSeriesItem> createState() => _TvSeriesItemState();
}

class _TvSeriesItemState extends State<TvSeriesItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final poster = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (AppColors.isDark ? Colors.black : const Color(0xFF1E293B))
                .withValues(
              alpha: AppColors.isDark
                  ? (_isPressed ? 0.2 : 0.4)
                  : (_isPressed ? 0.08 : 0.18),
            ),
            blurRadius: _isPressed ? 10 : 20,
            offset: Offset(0, _isPressed ? 4 : 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (c, u) => const ColoredBox(color: Color(0xff1A2333)),
              errorWidget: (c, u, e) => const ColoredBox(
                color: Color(0xff1A2333),
                child: Icon(
                  Icons.broken_image,
                  color: Colors.white24,
                  size: 36,
                ),
              ),
            ),
          ],
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
              SizedBox(
                height: 200,
                child: widget.showHero
                    ? Hero(tag: widget.heroTag, child: poster)
                    : poster,
              ),

              const SizedBox(height: 8),

              // Title — poster tagida
              Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 4),

              // Reyting + yil
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 15,
                    color: AppColors.rating,
                  ),

                  const SizedBox(width: 4),

                  Text(
                    widget.rating > 0 ? widget.rating.toStringAsFixed(1) : 'NR',
                    style: TextStyle(
                      color: AppColors.rating,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),

                  if (widget.year.isNotEmpty) ...[
                    const SizedBox(width: 6),

                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.textFaint,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      widget.year,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
