import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/primary_button.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController(text: 'ramesh.k@agrotech.in');
  final _passwordController = TextEditingController(text: 'brakshaa-demo');
  var _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _loading = true);
    await action();
    if (!mounted) return;
    setState(() => _loading = false);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.eco_outlined, color: theme.colorScheme.primary, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    l10n.t('auth_title'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.t('auth_subtitle'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  GlassCard(
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: l10n.t('email'),
                            prefixIcon: const Icon(Icons.alternate_email_rounded),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: l10n.t('password'),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                          ),
                        ),
                        const SizedBox(height: 18),
                        PrimaryButton(
                          label: 'Email Login',
                          icon: Icons.login_rounded,
                          loading: _loading,
                          onPressed: () => _run(
                            () => ref.read(authControllerProvider.notifier).signInWithEmail(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        PrimaryButton(
                          label: l10n.t('google_login'),
                          icon: Icons.g_mobiledata_rounded,
                          outlined: true,
                          onPressed: () => _run(
                            ref.read(authControllerProvider.notifier).signInWithGoogle,
                          ),
                        ),
                        const SizedBox(height: 12),
                        PrimaryButton(
                          label: l10n.t('phone_login'),
                          icon: Icons.phone_iphone_rounded,
                          outlined: true,
                          onPressed: () => _run(
                            () => ref
                                .read(authControllerProvider.notifier)
                                .signInWithPhone('+91 98765 43210'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => _run(
                      ref.read(authControllerProvider.notifier).continueAsGuest,
                    ),
                    child: Text(l10n.t('continue_guest')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
