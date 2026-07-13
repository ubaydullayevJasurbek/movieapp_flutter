import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/feature/favourite/presentation/page/favourite_page.dart';
import 'package:movieapp/feature/home/presentation/page/home_page.dart';
import 'package:movieapp/feature/profile/profile_page.dart';
import 'package:movieapp/feature/search/presentation/page/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentScreen = 0;

  static const int _homeIndex = 0;
  static const int _searchIndex = 2;

  /// Owned here so the Home search shortcut can focus the Search tab's text
  /// field the moment we switch to it (the Search page stays alive inside the
  /// [IndexedStack], so its own `autofocus` only fires once, offstage).
  final FocusNode _searchFocusNode = FocusNode();

  /// Registered by the Search page. When it returns true it has consumed the
  /// back by stepping from a subpage (genre / results) to its own root, so the
  /// bottom navigation must stay on the Search tab.
  bool Function()? _onSearchBack;

  late final List<Widget> screens = [
    HomePage(onSearchTap: _openSearchTab),
    FavouritePage(onBrowse: () => setState(() => _currentScreen = _homeIndex)),
    SearchPage(
      focusNode: _searchFocusNode,
      onRegisterBack: (handler) => _onSearchBack = handler,
      onBack: () => setState(() => _currentScreen = _homeIndex),
    ),
    ProfilePage(),
  ];

  /// Home search bar shortcut: selects the Search tab (no new route) and focuses
  /// the search field so the keyboard opens automatically.
  void _openSearchTab() {
    if (_currentScreen != _searchIndex) {
      setState(() => _currentScreen = _searchIndex);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Central Android back handling. Preserves the navigation hierarchy:
  ///   1. Inside the Search tab, first step back within its own hierarchy
  ///      (genre / results subpage → search root) without switching tabs.
  ///   2. Otherwise, any non-Home tab returns to the Home tab.
  ///   3. On Home the system back is allowed to exit the app (see [canPop]).
  void _handleBack() {
    if (_currentScreen == _searchIndex && (_onSearchBack?.call() ?? false)) {
      return;
    }
    if (_currentScreen != _homeIndex) {
      setState(() => _currentScreen = _homeIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Only allow the system back to exit the app when already on Home.
      canPop: _currentScreen == _homeIndex,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: _currentScreen, children: screens),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 28),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
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
                  selectedIndex: _currentScreen,
                  backgroundColor: Colors.transparent,
                  haptic: true,
                  tabBorderRadius: 24,
                  curve: Curves.easeOutExpo,
                  duration: const Duration(milliseconds: 400),
                  gap: 6,
                  color: AppColors.textSecondary,
                  activeColor: AppColors.primary,
                  iconSize: 22,
                  tabBackgroundColor: AppColors.primary.withValues(alpha: 0.15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
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
      ),
    );
  }
}
