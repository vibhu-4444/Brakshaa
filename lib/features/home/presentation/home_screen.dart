import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/brakshaa_models.dart';
import '../../../repositories/brakshaa_repository.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/action_tile.dart';
import '../../../widgets/assistant_sheet.dart';
import '../../../widgets/brakshaa_top_bar.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/status_chip.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final dashboard = ref.watch(brakshaaRepositoryProvider).dashboard();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: BrakshaaTopBar(title: l10n.t('app_name')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 136),
          children: [
            Text(
              l10n.t('good_morning'),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 24,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 17),
                const SizedBox(width: 6),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      text: '${l10n.t('current_location')}: ',
                      children: [
                        TextSpan(
                          text: l10n.t('punjab'),
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            _WeatherCard(),
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SectionLabel(
                        icon: Icons.water_drop_outlined,
                        label: l10n.t('soil_moisture'),
                        color: theme.colorScheme.primary,
                      ),
                      StatusChip(label: l10n.t('optimal'), compact: true),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dashboard.soil.moisture}%',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: 27,
                            ),
                          ),
                          Text(
                            dashboard.soil.zone,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 58,
                        height: 58,
                        child: CircularProgressIndicator(
                          value: dashboard.soil.moisture / 100,
                          strokeWidth: 5,
                          backgroundColor: BrakshaaColors.surfaceContainer,
                          color: theme.colorScheme.primary,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(
                    icon: Icons.psychology_outlined,
                    label: l10n.t('ai_insights'),
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 14),
                  Text(l10n.t('wheat_nitrogen'), style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text(
                    l10n.t('nitrogen_copy'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: l10n.t('take_action'),
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      showBrakshaaSnack(context, 'Nitrogen action added to offline sync queue.');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SectionLabel(
                        icon: Icons.storefront_outlined,
                        label: l10n.t('market_prices'),
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      Text(
                        'Updated 1h ago',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  for (final price in dashboard.marketPrices) ...[
                    _MarketPriceRow(price: price),
                    if (price != dashboard.marketPrices.last)
                      Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.28)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(l10n.t('quick_actions'), style: theme.textTheme.headlineMedium?.copyWith(fontSize: 21)),
            const SizedBox(height: 16),
            SizedBox(
              height: 104,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ActionTile(
                    icon: Icons.document_scanner_outlined,
                    label: 'Scan\nDisease',
                    highlight: true,
                    onTap: () => context.go('/diagnose'),
                  ),
                  ActionTile(
                    icon: Icons.smart_toy_outlined,
                    label: 'Ask\nAI',
                    highlight: true,
                    onTap: () => showAssistantSheet(context),
                  ),
                  ActionTile(
                    icon: Icons.calendar_month_outlined,
                    label: 'Crop\nPlanner',
                    onTap: () => showBrakshaaSnack(context, 'Crop planner opened in demo mode.'),
                  ),
                  ActionTile(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Expense\nTracker',
                    onTap: () => context.go('/market'),
                  ),
                  ActionTile(
                    icon: Icons.account_balance_outlined,
                    label: 'Gov\nSchemes',
                    onTap: () => showBrakshaaSnack(context, 'Gov schemes saved for offline reading.'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _AlertCard(
              color: BrakshaaColors.error,
              icon: Icons.warning_amber_rounded,
              label: l10n.t('disease_alert'),
              title: l10n.t('yellow_rust'),
              body: l10n.t('yellow_rust_copy'),
            ),
            const SizedBox(height: 20),
            _AlertCard(
              color: BrakshaaColors.gold,
              icon: Icons.lightbulb_outline_rounded,
              label: l10n.t('daily_tip'),
              title: l10n.t('water_conservation'),
              body: l10n.t('water_conservation_copy'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final weather = ref.watch(brakshaaRepositoryProvider).dashboard().weather;
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel(
                  icon: Icons.wb_cloudy_outlined,
                  label: l10n.t('today_forecast'),
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    text: weather.temperature,
                    children: [
                      TextSpan(
                        text: ' / ${weather.low}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  style: theme.textTheme.displayLarge?.copyWith(fontSize: 42),
                ),
                const SizedBox(height: 8),
                Text(
                  weather.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            'assets/images/weather_icon.png',
            width: 74,
            height: 74,
            errorBuilder: (_, __, ___) => Icon(
              Icons.wb_cloudy_outlined,
              color: theme.colorScheme.primary,
              size: 42,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3,
                ),
          ),
        ),
      ],
    );
  }
}

class _MarketPriceRow extends StatelessWidget {
  const _MarketPriceRow({required this.price});

  final MarketPrice price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = price.up ? theme.colorScheme.primary : theme.colorScheme.error;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(price.crop, style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price.price, style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20)),
              Row(
                children: [
                  Icon(
                    price.up ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                    color: color,
                    size: 15,
                  ),
                  Text(
                    price.delta,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.color,
    required this.icon,
    required this.label,
    required this.title,
    required this.body,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      borderColor: color.withValues(alpha: 0.3),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(width: 3, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(99))),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(icon: icon, label: label, color: color),
                  const SizedBox(height: 10),
                  Text(title, style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20)),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
