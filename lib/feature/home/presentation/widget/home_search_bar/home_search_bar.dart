import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _hasText = _searchController.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF1E293B),
              hintText: "Movie searching...",
              hintStyle: const TextStyle(color: Color(0xFF475569)),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
              suffixIcon: _hasText
                  ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () => _searchController.clear(),
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}