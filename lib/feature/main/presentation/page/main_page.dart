import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movieapp/feature/category/category_page.dart';
import 'package:movieapp/feature/favourite/favourite_page.dart';
import 'package:movieapp/feature/home/presentation/page/home_page.dart';
import 'package:movieapp/feature/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentScreen = 0;

  final List<Widget> screens = [
    HomePage(),
    CategoryPage(),
    FavouritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentScreen, children: screens),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 28),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GNav(
                backgroundColor: Colors.transparent,
                haptic: true,
                tabBorderRadius: 24,
                curve: Curves.easeOutExpo,
                duration: const Duration(milliseconds: 400),
                gap: 6,
                color: Colors.white,
                activeColor: Colors.lightGreenAccent,
                iconSize: 22,
                tabBackgroundColor: Colors.purpleAccent.withValues(alpha: 0.15),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                onTabChange: (index) {
                  setState(() {
                    _currentScreen = index;
                  });
                },
                tabs: const [
                  GButton(icon: Icons.home_rounded, text: 'Home'),
                  GButton(icon: Icons.favorite_rounded, text: 'Favourite'),
                  GButton(icon: Icons.search_rounded, text: 'Search'),
                  GButton(icon: Icons.person_rounded, text: 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}