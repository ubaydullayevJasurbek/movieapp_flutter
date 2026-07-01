import 'package:flutter/material.dart';

class TaglineSection extends StatelessWidget {
  final String? tagline;

  const TaglineSection({
    super.key,
    this.tagline,
  });

  @override
  Widget build(BuildContext context) {
    if (tagline == null || tagline!.isEmpty) {
      return const SizedBox();
    }

    return Text(
      tagline!,
      style: const TextStyle(
        color: Colors.white,
        fontStyle: FontStyle.italic,
        fontSize: 16,
      ),
    );
  }
}