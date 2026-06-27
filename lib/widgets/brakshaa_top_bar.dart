import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class BrakshaaTopBar extends StatelessWidget implements PreferredSizeWidget {
  const BrakshaaTopBar({
    super.key,
    this.title = 'Brakshaa',
    this.leading,
    this.showBack = false,
    this.onBack,
    this.trailing,
  });

  final String title;
  final Widget? leading;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: AppBar(
          toolbarHeight: 64,
          backgroundColor:
              isDark ? Colors.black.withValues(alpha: 0.34) : Colors.white.withValues(alpha: 0.72),
          leadingWidth: 64,
          leading: showBack
              ? IconButton(
                  tooltip: 'Back',
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                )
              : leading ??
                  IconButton(
                    tooltip: 'Brakshaa',
                    onPressed: () {},
                    icon: const Icon(Icons.eco_outlined),
                  ),
          title: Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          actions: [
            trailing ??
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Notifications',
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_rounded),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: BrakshaaColors.error,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
