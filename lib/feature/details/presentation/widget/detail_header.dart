import 'package:flutter/material.dart';

class DetailHeader extends StatelessWidget {
  final String? backdropUrl;
  final VoidCallback onBack;
  final VoidCallback onBookmark;
  final VoidCallback onShare;

  const DetailHeader({
    super.key,
    required this.backdropUrl,
    required this.onBack,
    required this.onBookmark,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// BACKDROP
          backdropUrl != null
              ? Image.network(backdropUrl!, fit: BoxFit.cover)
              : Container(color: Colors.grey.shade900),

          /// DARK GRADIENT
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color.fromARGB(80, 0, 0, 0),
                  Color(0xff08111F),
                ],
              ),
            ),
          ),

          /// TOP BUTTONS
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circleButton(Icons.arrow_back, onTap: onBack),
                Row(
                  children: [
                    _circleButton(Icons.bookmark_border, onTap: onBookmark),
                    const SizedBox(width: 12),
                    _circleButton(Icons.share, onTap: onShare),
                  ],
                ),
              ],
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
                color: Colors.white.withOpacity(.25),
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
