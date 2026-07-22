import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

class HeroIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  /// Foydalanuvchi biror nuqtaga bosganda chaqiriladi.
  /// Berilmasa (null), indikator faqat vizual ko'rsatkich sifatida ishlaydi.
  final ValueChanged<int>? onTap;

  const HeroIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final bool isActive = i == currentIndex;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap == null ? null : () => onTap!(i),
          // Tegish maydonini kattalashtirish — kichik nuqtalarga
          // barmoq bilan aniq tegish uchun.
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: 8,
              width: isActive ? 22 : 8,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.heroAccent
                    : AppColors.onScrim.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      }),
    );
  }
}
