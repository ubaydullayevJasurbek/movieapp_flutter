import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NowPlayingItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final String year;
  final VoidCallback onTap;

  const NowPlayingItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.year,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: imageUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                     imageUrl:  imageUrl,
                      width: 140,
                      height: 210,
                      fit: BoxFit.cover,
                    ),

                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.25),
                              Colors.black.withValues(alpha: 0.75),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: Color(0xffF6C344),
                ),

                const SizedBox(width: 4),

                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Color(0xffF6C344),
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(width: 6),

                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.white38,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  year,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}