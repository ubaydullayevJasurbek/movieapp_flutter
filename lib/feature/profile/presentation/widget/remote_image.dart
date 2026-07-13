import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

/// Network image that fades in when loaded and degrades gracefully to a tinted
/// placeholder icon while loading or on error. Keeps the profile UI intact even
/// with no connectivity.
class RemoteImage extends StatelessWidget {
  final String url;
  final IconData fallbackIcon;
  final double? width;
  final double? height;

  const RemoteImage({
    super.key,
    required this.url,
    this.fallbackIcon = Icons.image_rounded,
    this.width,
    this.height,
  });

  Widget _placeholder() => Container(
        width: width,
        height: height,
        color: AppColors.surfaceHigh,
        child: Icon(fallbackIcon, color: AppColors.textFaint, size: 28),
      );

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => _placeholder(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: child,
          );
        }
        return _placeholder();
      },
    );
  }
}
