import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, this.onTap});

  /// Shortcut to the Search tab. This bar never performs a search itself — it
  /// only switches the [MainPage] bottom navigation to the Search tab, which
  /// [MainPage] wires to [_openSearchTab]. No route is pushed.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 72, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Good evening",
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "What would you\nlike to watch?",
            style: GoogleFonts.aBeeZee(
              color: const Color(0xFFF1F5F9),
              fontSize: 24,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Material(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search_rounded, color: Colors.white54),
                    SizedBox(width: 12),
                    Text(
                      "Movie searching...",
                      style: TextStyle(color: Color(0xFF475569), fontSize: 15),
                    ),
                    Spacer(),
                    Icon(Icons.mic_rounded, color: Colors.white38),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}