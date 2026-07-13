import 'package:flutter/material.dart';

/// The signed-in user rendered by the profile header.
@immutable
class ProfileUser {
  final String name;
  final String email;
  final String avatarUrl;
  final bool isPremium;
  final String memberSince;

  const ProfileUser({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.isPremium,
    required this.memberSince,
  });
}

/// A single headline metric shown in the statistics grid.
@immutable
class ProfileStat {
  final String label;
  final String value;
  final IconData icon;
  final List<Color> gradient;

  const ProfileStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.gradient,
  });
}

/// A partially-watched title shown in the "Continue watching" carousel.
@immutable
class ContinueWatchingItem {
  final String title;
  final String posterUrl;
  final double progress; // 0..1
  final String remaining;

  const ContinueWatchingItem({
    required this.title,
    required this.posterUrl,
    required this.progress,
    required this.remaining,
  });
}

/// Static presentation data for the profile screen. Kept in one place so the
/// widgets stay dumb, const-friendly and free of rebuild-triggering logic.
class ProfileData {
  ProfileData._();

  static const ProfileUser user = ProfileUser(
    name: 'Jasurbek Ubaydullayev',
    email: 'ubaydullayevjasurbek777@gmail.com',
    avatarUrl: 'https://i.pravatar.cc/300?img=12',
    isPremium: true,
    memberSince: 'Member since 2023',
  );

  static const List<ProfileStat> stats = [
    ProfileStat(
      label: 'Movies Watched',
      value: '1,204',
      icon: Icons.movie_rounded,
      gradient: [Color(0xFFF6C344), Color(0xFFFF8A00)],
    ),
    ProfileStat(
      label: 'Favorites',
      value: '318',
      icon: Icons.favorite_rounded,
      gradient: [Color(0xFFE50914), Color(0xFFFF5F6D)],
    ),
    ProfileStat(
      label: 'Watchlist',
      value: '76',
      icon: Icons.bookmark_rounded,
      gradient: [Color(0xFF3B82F6), Color(0xFF6366F1)],
    ),
    ProfileStat(
      label: 'Reviews',
      value: '42',
      icon: Icons.rate_review_rounded,
      gradient: [Color(0xFF10B981), Color(0xFF06B6D4)],
    ),
  ];

  static const List<ContinueWatchingItem> continueWatching = [
    ContinueWatchingItem(
      title: 'Dune: Part Two',
      posterUrl: 'https://picsum.photos/seed/dune2/300/450',
      progress: 0.68,
      remaining: '48 min left',
    ),
    ContinueWatchingItem(
      title: 'Oppenheimer',
      posterUrl: 'https://picsum.photos/seed/oppen/300/450',
      progress: 0.32,
      remaining: '1h 52m left',
    ),
    ContinueWatchingItem(
      title: 'The Batman',
      posterUrl: 'https://picsum.photos/seed/batman/300/450',
      progress: 0.85,
      remaining: '22 min left',
    ),
    ContinueWatchingItem(
      title: 'Interstellar',
      posterUrl: 'https://picsum.photos/seed/inter/300/450',
      progress: 0.12,
      remaining: '2h 30m left',
    ),
    ContinueWatchingItem(
      title: 'Blade Runner 2049',
      posterUrl: 'https://picsum.photos/seed/blade/300/450',
      progress: 0.54,
      remaining: '1h 18m left',
    ),
  ];
}
