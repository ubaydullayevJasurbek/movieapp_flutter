import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

/// Search input used to filter the favourites list by title.
class FavouritesSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const FavouritesSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search favourites',
          hintStyle: TextStyle(color: AppColors.textFaint),
          prefixIcon: Icon(Icons.search_rounded, color: AppColors.textFaint),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close_rounded, color: AppColors.textFaint),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
          filled: true,
          fillColor: AppColors.fill,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
