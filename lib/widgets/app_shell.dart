import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/app_localizations.dart';
import '../core/theme/app_theme.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.location,
    required this.child,
    super.key,
  });

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final showScanFab = location == '/home';

    return Scaffold(
      extendBody: true,
      body: child,
      floatingActionButton: showScanFab
          ? Padding(
              padding: const EdgeInsets.only(bottom: 74),
              child: FloatingActionButton(
                heroTag: 'scan-fab',
                tooltip: 'Scan disease',
                onPressed: () => context.go('/diagnose'),
                backgroundColor: BrakshaaColors.primary,
                foregroundColor: Colors.white,
                child: const Icon(Icons.document_scanner_outlined),
              ),
            )
          : null,
      bottomNavigationBar: _GlassBottomNavigation(
        location: location,
        onSelected: (path) => context.go(path),
      ),
    );
  }
}

class _GlassBottomNavigation extends StatelessWidget {
  const _GlassBottomNavigation({
    required this.location,
    required this.onSelected,
  });

  final String location;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      _NavItem('/home', Icons.home_outlined, Icons.home_rounded, l10n.t('home')),
      _NavItem('/diagnose', Icons.psychology_outlined, Icons.psychology, l10n.t('diagnose')),
      _NavItem('/community', Icons.groups_outlined, Icons.groups, l10n.t('community')),
      _NavItem('/market', Icons.storefront_outlined, Icons.storefront, l10n.t('market')),
      _NavItem('/profile', Icons.person_outline_rounded, Icons.person, l10n.t('profile')),
    ];
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            10 + MediaQuery.paddingOf(context).bottom,
          ),
          decoration: BoxDecoration(
            color: isDark ? Colors.black.withValues(alpha: 0.56) : Colors.white.withValues(alpha: 0.82),
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.34 : 0.08),
                blurRadius: 36,
                offset: const Offset(0, -12),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final item in items)
                Expanded(
                  child: _BottomNavButton(
                    item: item,
                    active: location == item.path,
                    onTap: () => onSelected(item.path),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavButton extends StatelessWidget {
  const _BottomNavButton({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final _NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7);

    return Semantics(
      selected: active,
      button: true,
      label: item.label,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
          decoration: BoxDecoration(
            color: active ? activeColor.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? item.activeIcon : item.icon, color: active ? activeColor : inactiveColor),
                const SizedBox(height: 3),
                Text(
                  item.label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: active ? activeColor : inactiveColor,
                    fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.path, this.icon, this.activeIcon, this.label);

  final String path;
  final IconData icon;
  final IconData activeIcon;
  final String label;
}
