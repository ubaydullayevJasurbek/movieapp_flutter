import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

class CastTitle extends StatelessWidget {
  const CastTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Cast",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        const Spacer(),

        const Text(
          "See all",
          style: TextStyle(
            color: AppColors.danger,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
