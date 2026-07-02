import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HeroIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const HeroIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      count: count,
      effect: const ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 4,
        spacing: 6,
        activeDotColor: Color(0xffFFD054),
        dotColor: Colors.white30,
      ),
    );
  }
}