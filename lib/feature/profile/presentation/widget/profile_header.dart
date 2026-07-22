import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

import '../model/profile_view_data.dart';
import 'remote_image.dart';

/// Premium profile header: gradient-ringed avatar with a verified premium
/// badge, name, email, a premium pill and an edit-profile action.
class ProfileHeader extends StatelessWidget {
  final ProfileUser user;
  final VoidCallback? onEdit;

  const ProfileHeader({super.key, required this.user, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Avatar(url: user.avatarUrl, showBadge: user.isPremium),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (user.isPremium) ...[
              const SizedBox(width: 8),
              const _PremiumPill(),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          user.email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          user.memberSince,
          style: TextStyle(color: AppColors.textFaint, fontSize: 12),
        ),
        const SizedBox(height: 18),
        _EditProfileButton(onTap: onEdit),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final String url;
  final bool showBadge;

  const _Avatar({required this.url, required this.showBadge});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 116,
      height: 116,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Hero(
            tag: 'profile-avatar',
            child: Container(
              width: 112,
              height: 112,
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.danger],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66F6C344),
                    blurRadius: 22,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
                child: ClipOval(
                  child: RemoteImage(
                    url: url,
                    fallbackIcon: Icons.person_rounded,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
          if (showBadge)
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  border: Border.all(color: AppColors.background, width: 3),
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  size: 18,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PremiumPill extends StatelessWidget {
  const _PremiumPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFFF6C344), Color(0xFFFF8A00)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_rounded,
              size: 14, color: AppColors.onPrimary),
          SizedBox(width: 4),
          Text(
            'PREMIUM',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _EditProfileButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fill,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.6)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_rounded, size: 16, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
