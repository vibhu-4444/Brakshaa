import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../generated/assets.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/status_chip.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => context.go('/auth'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'LAST UPDATED JUNE 2026',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 34),
        children: [
          Center(
            child: GlassCard(
              padding: const EdgeInsets.all(22),
              radius: 20,
              child: Icon(
                Icons.shield_rounded,
                color: theme.colorScheme.primary,
                size: 38,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your Privacy Matters',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 12),
          Text(
            'At Brakshaa, we believe farming intelligence starts with trust. Our commitment to transparency ensures your data remains your most valuable asset.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),
          const Row(
            children: [
              Expanded(
                child: _PolicyMetric(
                  icon: Icons.timer_outlined,
                  label: 'Reading Time',
                  value: '5 Min',
                  color: BrakshaaColors.gold,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _PolicyMetric(
                  icon: Icons.translate_rounded,
                  label: 'Version',
                  value: 'v1.0',
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _PolicyMetric(
            icon: Icons.event_available_outlined,
            label: 'Effective Date',
            value: 'June 12, 2026',
            color: BrakshaaColors.primary,
          ),
          const SizedBox(height: 28),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: "Search policy sections (e.g. 'Location', 'AI')...",
              prefixIcon: Icon(Icons.search_rounded),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  widthFactor: 1,
                  child: Text('CMD+K'),
                ),
              ),
            ),
            onSubmitted: (value) => showBrakshaaSnack(
              context,
              value.trim().isEmpty
                  ? 'Search policy sections by keyword.'
                  : 'Showing policy matches for "$value".',
            ),
          ),
          const SizedBox(height: 24),
          const _LegalExpansionCard(
            icon: Icons.dataset_outlined,
            title: 'Information We Collect',
            subtitle: 'Data you provide and automated logs.',
            initiallyExpanded: true,
            children: [
              Text(
                'We collect information to provide better services to all our users, from figuring out basic stuff like which language you speak, to more complex things like soil nutrient optimization models.',
              ),
              SizedBox(height: 12),
              _BulletText('Account Information: Name, email, and farm location.'),
              _BulletText('Sensor Data: Moisture levels, temperature, and pH values uploaded via IoT devices.'),
              _BulletText('Camera Data: Crop photos analyzed by our AI diagnostic engine.'),
            ],
          ),
          const SizedBox(height: 14),
          const _LegalExpansionCard(
            icon: Icons.sync_alt_rounded,
            title: 'How We Use Data',
            subtitle: 'Improving your yield with AI intelligence.',
            children: [
              Text(
                'Brakshaa uses profile, farm, crop, weather, and diagnostic signals to personalize recommendations, alerts, reports, and product improvements.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          GlassCard(
            borderColor: theme.colorScheme.primary.withValues(alpha: 0.32),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.photo_camera_outlined),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Camera & Photo Access',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const StatusChip(
                            label: 'Sensitive',
                            color: BrakshaaColors.error,
                            compact: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Our AI requires access to your camera to identify pests and diseases. Images are processed locally when possible, but complex diagnosis may require cloud analysis.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const _PrivacyAssurance(
                  text: 'We do NOT access your personal photo library without permission.',
                ),
                SizedBox(height: 10),
                const _PrivacyAssurance(
                  text: 'Analyzed images are anonymized to improve global farm health models.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const _LegalExpansionCard(
            icon: Icons.location_on_outlined,
            title: 'Location Services',
            subtitle: 'Precise weather and regional pest alerts.',
            children: [
              Text(
                'Location is used to localize forecasts, mandi prices, disease alerts, and government scheme guidance.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _LegalExpansionCard(
            icon: Icons.auto_awesome_rounded,
            title: 'AI Recommendations',
            subtitle: 'How our algorithms influence your farm.',
            children: [
              Text(
                'AI outputs are advisory and should be checked against local expert knowledge and physical field observations.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _LegalExpansionCard(
            icon: Icons.gavel_outlined,
            title: 'Your Rights',
            subtitle: 'Request, edit, or delete your data anytime.',
            children: [
              Text(
                'You can request access, correction, export, or deletion of your account and farm data through support.',
              ),
            ],
          ),
          const SizedBox(height: 42),
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Still have questions?',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Contact Support',
                  icon: Icons.support_agent_rounded,
                  onPressed: () => showBrakshaaSnack(
                    context,
                    'Support contact flow will connect to helpdesk.',
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Email Privacy Team',
                  icon: Icons.mail_outline_rounded,
                  outlined: true,
                  onPressed: () => showBrakshaaSnack(
                    context,
                    'privacy@brakshaa.ai copied.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          TextButton(
            onPressed: () => showBrakshaaSnack(context, 'Official website link ready.'),
            child: const Text('Official Brakshaa Website'),
          ),
          Text(
            '© 2026 Brakshaa AI Systems. All rights reserved.',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => context.go('/auth'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Terms of Service'),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: () => showBrakshaaSnack(context, 'Terms search ready.'),
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'More',
            onPressed: () => showBrakshaaSnack(context, 'More options opened.'),
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 34),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              BrakshaaAssets.termsHero,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Terms You Agree To',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 12),
          Text(
            'Welcome to Brakshaa. These terms define our legal relationship and describe your rights and responsibilities when using our intelligent farming ecosystem.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          const GlassCard(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TermsMetric(icon: Icons.schedule_rounded, value: '5 MIN READ'),
                _TermsMetric(icon: Icons.workspace_premium_outlined, value: 'VERSION 1.0'),
                _TermsMetric(icon: Icons.calendar_month_outlined, value: 'EFFECTIVE JUNE 2026'),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const _TermsExpansion(
            number: '1.',
            title: 'Eligibility',
            icon: Icons.person_check_alt_1_outlined,
            children: [
              Text(
                'You must be able to form a legal agreement and use Brakshaa only for agricultural, educational, or farm-management purposes.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _TermsExpansion(
            number: '2.',
            title: 'User Accounts',
            icon: Icons.manage_accounts_outlined,
            children: [
              Text(
                'You are responsible for keeping account information accurate and securing your login credentials.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _TermsExpansion(
            number: '3.',
            title: 'Acceptable Use',
            icon: Icons.gavel_outlined,
            children: [
              Text(
                'You agree not to use Brakshaa for any unlawful purpose, reverse-engineer AI models, overload infrastructure, or upload malicious field data.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _TermsExpansion(
            number: '4.',
            title: 'AI Advisory Services',
            icon: Icons.psychology_outlined,
            initiallyExpanded: true,
            color: BrakshaaColors.tertiary,
            children: [
              Text(
                'Brakshaa provides AI-driven agricultural insights. While our models are trained on high-precision data, they are provided "as-is." Agricultural outcomes depend on numerous external factors including weather, local ecosystem variables, and user implementation.',
              ),
              SizedBox(height: 16),
              _DisclaimerBox(),
            ],
          ),
          const SizedBox(height: 14),
          const _TermsExpansion(
            number: '5.',
            title: 'Intellectual Property',
            icon: Icons.copyright_outlined,
            children: [
              Text(
                'Brakshaa software, design, AI models, and brand assets remain protected intellectual property. Your farm data remains yours subject to the Privacy Policy.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _TermsExpansion(
            number: '6.',
            title: 'Limitation of Liability',
            icon: Icons.warning_amber_rounded,
            color: BrakshaaColors.error,
            children: [
              Text(
                'Brakshaa is not liable for crop loss, market loss, weather events, or decisions made solely from advisory outputs.',
              ),
            ],
          ),
          const SizedBox(height: 34),
          GlassCard(
            padding: const EdgeInsets.all(22),
            child: Text(
              'By clicking "I Agree" or by continuing to use the service, you acknowledge that you have read and understood these Terms of Service in their entirety.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            label: 'I AGREE & CONTINUE',
            icon: Icons.check_rounded,
            onPressed: () => context.go('/auth'),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundLegalAction(
                icon: Icons.download_rounded,
                onTap: () => showBrakshaaSnack(context, 'Terms PDF download ready.'),
              ),
              const SizedBox(width: 14),
              _RoundLegalAction(
                icon: Icons.share_outlined,
                onTap: () => showBrakshaaSnack(context, 'Terms link copied.'),
              ),
              const SizedBox(width: 14),
              _RoundLegalAction(
                icon: Icons.print_outlined,
                onTap: () => showBrakshaaSnack(context, 'Print dialog ready.'),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text(
            '© 2026 Brakshaa Agricultural Intelligence. All rights reserved.',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicyMetric extends StatelessWidget {
  const _PolicyMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(18),
      radius: 18,
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.outline,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalExpansionCard extends StatelessWidget {
  const _LegalExpansionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.children,
    this.initiallyExpanded = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: EdgeInsets.zero,
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.08),
          foregroundColor: theme.colorScheme.primary,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(subtitle),
        children: children,
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _PrivacyAssurance extends StatelessWidget {
  const _PrivacyAssurance({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: theme.colorScheme.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: theme.textTheme.bodySmall)),
        ],
      ),
    );
  }
}

class _TermsMetric extends StatelessWidget {
  const _TermsMetric({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flexible(
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: theme.colorScheme.primary,
            child: Icon(icon, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsExpansion extends StatelessWidget {
  const _TermsExpansion({
    required this.number,
    required this.title,
    required this.icon,
    required this.children,
    this.initiallyExpanded = false,
    this.color = BrakshaaColors.primary,
  });

  final String number;
  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool initiallyExpanded;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: EdgeInsets.zero,
      borderColor: initiallyExpanded ? color.withValues(alpha: 0.26) : null,
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(72, 0, 24, 24),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.08),
          foregroundColor: color,
          child: Icon(icon),
        ),
        title: Text.rich(
          TextSpan(
            text: '$number ',
            style: TextStyle(color: color.withValues(alpha: 0.75)),
            children: [
              TextSpan(
                text: title,
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ],
          ),
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        children: children,
      ),
    );
  }
}

class _DisclaimerBox extends StatelessWidget {
  const _DisclaimerBox();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: BrakshaaColors.tertiary),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Disclaimer', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(height: 6),
                Text(
                  'AI recommendations should be validated against local expert knowledge and physical field observations.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundLegalAction extends StatelessWidget {
  const _RoundLegalAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onTap,
      icon: Icon(icon),
    );
  }
}
