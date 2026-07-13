import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

import 'presentation/model/profile_view_data.dart';
import 'presentation/widget/continue_watching_section.dart';
import 'presentation/widget/logout_button.dart';
import 'presentation/widget/profile_header.dart';
import 'presentation/widget/profile_stats.dart';
import 'presentation/widget/settings_section.dart';
import 'presentation/widget/settings_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const double _hPad = 20;

  void _soon(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surface,
          content: Text(
            '$label — coming soon',
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ),
      );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Log out?',
            style: TextStyle(color: AppColors.textPrimary)),
        content: const Text(
          'You will need to sign in again to access your library.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Log out',
                style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.surface,
            content: Text('Logged out',
                style: TextStyle(color: AppColors.textPrimary)),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const _TopGlow(),
          SafeArea(
            bottom: false,
            child: _IntroFade(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 12, bottom: 120 + bottomInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: _hPad),
                      child: ProfileHeader(
                        user: ProfileData.user,
                        onEdit: () => _soon(context, 'Edit profile'),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: _hPad),
                      child: ProfileStats(stats: ProfileData.stats),
                    ),
                    const SizedBox(height: 28),
                    ContinueWatchingSection(
                      items: ProfileData.continueWatching,
                      onTap: (item) => _soon(context, item.title),
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: _hPad),
                      child: Column(
                        children: [
                          _library(context),
                          const SizedBox(height: 22),
                          _preferences(context),
                          const SizedBox(height: 22),
                          _account(context),
                          const SizedBox(height: 22),
                          _support(context),
                          const SizedBox(height: 30),
                          LogoutButton(onTap: () => _confirmLogout(context)),
                          const SizedBox(height: 16),
                          const Text(
                            'Lumina • v1.0.0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textFaint,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _library(BuildContext context) {
    return SettingsSection(
      title: 'Library',
      children: [
        SettingsTile(
          icon: Icons.favorite_rounded,
          iconColor: AppColors.danger,
          title: 'Favorite Movies',
          subtitle: '318 titles',
          onTap: () => _soon(context, 'Favorite Movies'),
        ),
        SettingsTile(
          icon: Icons.bookmark_rounded,
          iconColor: const Color(0xFF3B82F6),
          title: 'Watchlist',
          subtitle: '76 titles to watch',
          onTap: () => _soon(context, 'Watchlist'),
        ),
        SettingsTile(
          icon: Icons.download_rounded,
          iconColor: const Color(0xFF10B981),
          title: 'Downloads',
          subtitle: '12 available offline',
          onTap: () => _soon(context, 'Downloads'),
        ),
      ],
    );
  }

  Widget _preferences(BuildContext context) {
    return SettingsSection(
      title: 'Preferences',
      children: [
        SettingsTile(
          icon: Icons.dark_mode_rounded,
          title: 'Theme',
          subtitle: 'Dark',
          onTap: () => _soon(context, 'Theme'),
        ),
        SettingsTile(
          icon: Icons.language_rounded,
          iconColor: const Color(0xFF6366F1),
          title: 'Language',
          subtitle: 'English (US)',
          onTap: () => _soon(context, 'Language'),
        ),
        const PreferenceSwitchTile(
          icon: Icons.notifications_rounded,
          title: 'Notifications',
          subtitleOn: 'Enabled',
          subtitleOff: 'Muted',
          initialValue: true,
        ),
        SettingsTile(
          icon: Icons.high_quality_rounded,
          iconColor: const Color(0xFF06B6D4),
          title: 'Download Quality',
          subtitle: 'HD • 1080p',
          onTap: () => _soon(context, 'Download Quality'),
        ),
      ],
    );
  }

  Widget _account(BuildContext context) {
    return SettingsSection(
      title: 'Account',
      children: [
        SettingsTile(
          icon: Icons.person_rounded,
          title: 'Edit Profile',
          subtitle: 'Name, avatar and email',
          onTap: () => _soon(context, 'Edit Profile'),
        ),
        SettingsTile(
          icon: Icons.lock_rounded,
          iconColor: const Color(0xFF6366F1),
          title: 'Privacy',
          subtitle: 'Control what others see',
          onTap: () => _soon(context, 'Privacy'),
        ),
        SettingsTile(
          icon: Icons.shield_rounded,
          iconColor: const Color(0xFF10B981),
          title: 'Security',
          subtitle: 'Password and 2FA',
          onTap: () => _soon(context, 'Security'),
        ),
        SettingsTile(
          icon: Icons.devices_rounded,
          iconColor: const Color(0xFF3B82F6),
          title: 'Connected Devices',
          subtitle: '3 active devices',
          onTap: () => _soon(context, 'Connected Devices'),
        ),
      ],
    );
  }

  Widget _support(BuildContext context) {
    return SettingsSection(
      title: 'Support',
      children: [
        SettingsTile(
          icon: Icons.help_center_rounded,
          title: 'Help Center',
          onTap: () => _soon(context, 'Help Center'),
        ),
        SettingsTile(
          icon: Icons.star_rounded,
          title: 'Rate App',
          onTap: () => _soon(context, 'Rate App'),
        ),
        SettingsTile(
          icon: Icons.ios_share_rounded,
          iconColor: const Color(0xFF3B82F6),
          title: 'Share App',
          onTap: () => _soon(context, 'Share App'),
        ),
        SettingsTile(
          icon: Icons.feedback_rounded,
          iconColor: const Color(0xFF10B981),
          title: 'Send Feedback',
          onTap: () => _soon(context, 'Send Feedback'),
        ),
        SettingsTile(
          icon: Icons.info_rounded,
          title: 'About',
          subtitle: 'Version, licenses and terms',
          onTap: () => _soon(context, 'About'),
        ),
      ],
    );
  }
}

/// One-time fade + slide-up intro applied to the whole screen.
class _IntroFade extends StatelessWidget {
  final Widget child;

  const _IntroFade({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * 16),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// Soft gold radial glow behind the header.
class _TopGlow extends StatelessWidget {
  const _TopGlow();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Container(
          height: 340,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.7),
              radius: 0.9,
              colors: [
                AppColors.primary.withValues(alpha: 0.16),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
