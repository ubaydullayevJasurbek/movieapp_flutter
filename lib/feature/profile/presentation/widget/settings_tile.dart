import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

/// Leading gradient-tinted icon chip shared by every settings row.
class _TileIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _TileIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

/// Tappable settings row: leading icon, title, optional subtitle and a trailing
/// widget (defaults to a chevron). Ripple feedback via [InkWell].
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _TileIcon(icon: icon, color: color),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              trailing ??
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textFaint,
                    size: 22,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A settings row whose trailing control is a toggle. Keeps its own state and
/// animates the icon tint between on/off.
class PreferenceSwitchTile extends StatefulWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitleOn;
  final String subtitleOff;
  final bool initialValue;

  const PreferenceSwitchTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitleOn,
    required this.subtitleOff,
    this.initialValue = true,
  });

  @override
  State<PreferenceSwitchTile> createState() => _PreferenceSwitchTileState();
}

class _PreferenceSwitchTileState extends State<PreferenceSwitchTile> {
  late bool _value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    final color = widget.iconColor ?? AppColors.primary;
    return SettingsTile(
      icon: widget.icon,
      iconColor: _value ? color : AppColors.textFaint,
      title: widget.title,
      subtitle: _value ? widget.subtitleOn : widget.subtitleOff,
      onTap: () => setState(() => _value = !_value),
      trailing: Switch.adaptive(
        value: _value,
        onChanged: (v) => setState(() => _value = v),
        activeThumbColor: AppColors.onPrimary,
        activeTrackColor: AppColors.primary,
        inactiveThumbColor: AppColors.textMuted,
        inactiveTrackColor: AppColors.fill,
      ),
    );
  }
}
