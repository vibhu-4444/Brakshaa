import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/brakshaa_models.dart';
import '../../../repositories/brakshaa_repository.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/status_chip.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(brakshaaRepositoryProvider).profile();
    final settings = ref.watch(settingsControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 136),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.t('profile'),
                    style: theme.textTheme.headlineLarge?.copyWith(fontSize: 28),
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: 'Settings',
                  onPressed: () => showBrakshaaSnack(context, 'Settings opened.'),
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
            const SizedBox(height: 28),
            _ProfileHero(profile: profile),
            const SizedBox(height: 28),
            _ProfileSection(
              icon: Icons.agriculture_outlined,
              title: l10n.t('farm_details'),
              children: [
                _ChevronRow(
                  title: profile.farmName,
                  subtitle: '${profile.farmSize} • ${profile.crops.join(', ')}',
                  onTap: () => showBrakshaaSnack(context, 'Farm details editor opened.'),
                ),
                _ChevronRow(
                  title: 'Location & Soil',
                  subtitle: '${profile.location} • ${profile.soilType}',
                  onTap: () => showBrakshaaSnack(context, 'Location and soil editor opened.'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _ProfileSection(
              icon: Icons.tune_rounded,
              title: l10n.t('preferences'),
              children: [
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(l10n.t('language')),
                  trailing: DropdownButton<Locale>(
                    value: settings.locale,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(value: Locale('en'), child: Text('English')),
                      DropdownMenuItem(value: Locale('hi'), child: Text('Hindi')),
                    ],
                    onChanged: (locale) {
                      if (locale == null) return;
                      ref.read(settingsControllerProvider.notifier).changeLocale(locale);
                    },
                  ),
                ),
                SwitchListTile.adaptive(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: Text(l10n.t('dark_mode')),
                  value: settings.darkMode,
                  onChanged: ref.read(settingsControllerProvider.notifier).toggleTheme,
                ),
                SwitchListTile.adaptive(
                  secondary: const Icon(Icons.notifications_none_rounded),
                  title: Text(l10n.t('push_alerts')),
                  value: settings.pushAlertsEnabled,
                  onChanged: (enabled) async {
                    ref.read(settingsControllerProvider.notifier).togglePushAlerts(enabled);
                    if (enabled) {
                      await ref.read(notificationControllerProvider.notifier).enablePushAlerts();
                    } else {
                      await ref.read(notificationControllerProvider.notifier).disablePushAlerts();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            _ProfileSection(
              icon: Icons.help_outline_rounded,
              title: l10n.t('support'),
              children: [
                _ChevronRow(
                  title: 'Contact Agronomist',
                  icon: Icons.support_agent_rounded,
                  onTap: () => showBrakshaaSnack(context, 'Agronomist chat opened.'),
                ),
                _ChevronRow(
                  title: 'Help Center & FAQ',
                  icon: Icons.menu_book_outlined,
                  onTap: () => showBrakshaaSnack(context, 'Help center available offline.'),
                ),
                _ChevronRow(
                  title: 'Privacy Policy',
                  icon: Icons.shield_outlined,
                  onTap: () => showBrakshaaSnack(context, 'Privacy policy opened.'),
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded, color: theme.colorScheme.error),
                  title: Text(
                    l10n.t('sign_out'),
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  onTap: () async {
                    await ref.read(authControllerProvider.notifier).signOut();
                    if (context.mounted) context.go('/auth');
                  },
                ),
              ],
            ),
            const SizedBox(height: 42),
            Text(
              'Brakshaa 3.0 • Version 3.1.4',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.profile});

  final FarmerProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.28), width: 4),
                ),
                child: const CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage('assets/images/farmer_avatar.png'),
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                child: const Icon(Icons.edit_rounded, size: 17),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            profile.name,
            style: theme.textTheme.headlineMedium?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            '${profile.email}  •  ${profile.phone}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: const [
              StatusChip(label: 'Verified Farmer', icon: Icons.verified_outlined),
              StatusChip(label: 'Pro Member', icon: Icons.workspace_premium_outlined, color: BrakshaaColors.tertiary),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                title.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _ChevronRow extends StatelessWidget {
  const _ChevronRow({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon == null ? null : Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
  }
}
