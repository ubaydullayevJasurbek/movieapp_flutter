import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

class DetailHeader extends StatelessWidget {
  final String? backdropUrl;
  final VoidCallback onBack;
  final VoidCallback onBookmark;
  final VoidCallback onShare;
  final bool isSaved;

  const DetailHeader({
    super.key,
    required this.backdropUrl,
    required this.onBack,
    required this.onBookmark,
    required this.onShare,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * .48;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// BACKDROP IMAGE
          backdropUrl != null
              ? Image.network(
            backdropUrl!,
            fit: BoxFit.cover,
          )
              : Container(
            color: AppColors.surface,
          ),

          /// TOP & BOTTOM GRADIENT
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.20, 0.65, 1],
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          /// PLAY BUTTON
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.45),
                    blurRadius: 25,
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 46,
              ),
            ),
          ),

          /// TOP ACTION BUTTONS
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circleButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: onBack,
                    ),
                    Row(
                      children: [
                        _circleButton(
                          icon: isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          onTap: onBookmark,
                          iconColor: isSaved
                              ? AppColors.primary
                              : Colors.white,
                        ),
                        const SizedBox(width: 12),
                        _circleButton(
                          icon: Icons.share_rounded,
                          onTap: onShare,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
              shadows: const [
                Shadow(color: Colors.black54, blurRadius: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}