import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_state.dart';
import '../../../generated/assets.dart';
import '../../../utils/snackbar.dart';
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
  final _nameController = TextEditingController(text: 'Ramesh Kumar');
  var _signUp = false;
  var _remember = false;
  var _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              BrakshaaAssets.authFieldBackground,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.18),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.scaffoldBackgroundColor.withValues(alpha: 0.82),
                    theme.scaffoldBackgroundColor.withValues(alpha: 0.62),
                    theme.colorScheme.primary.withValues(alpha: 0.10),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.eco_outlined,
                            color: theme.colorScheme.primary,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Brakshaa 3.0',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Cultivating the Future',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "Join the world's most advanced AI\nfarming ecosystem.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 42),
                      GlassCard(
                        padding: const EdgeInsets.fromLTRB(36, 34, 36, 34),
                        radius: 28,
                        child: Column(
                          children: [
                            _AuthTabs(
                              signUp: _signUp,
                              onChanged: (value) => setState(() => _signUp = value),
                            ),
                            const SizedBox(height: 28),
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 180),
                              crossFadeState: _signUp
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: const SizedBox.shrink(),
                              secondChild: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextField(
                                  controller: _nameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: 'Full name',
                                    prefixIcon: Icon(Icons.person_outline_rounded),
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Email address',
                                prefixIcon: Icon(Icons.alternate_email_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  value: _remember,
                                  onChanged: (value) =>
                                      setState(() => _remember = value ?? false),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Remember me',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => showBrakshaaSnack(
                                    context,
                                    'Password reset link flow is ready for Firebase Auth.',
                                  ),
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            PrimaryButton(
                              label: 'Get Started',
                              icon: Icons.arrow_forward_rounded,
                              loading: _loading,
                              onPressed: () => _run(
                                () => ref
                                    .read(authControllerProvider.notifier)
                                    .signInWithEmail(
                                      _emailController.text,
                                      _passwordController.text,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            _AuthTabs(
                              signUp: _signUp,
                              compact: true,
                              onChanged: (value) => setState(() => _signUp = value),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: _SocialButton(
                                    label: 'Google',
                                    icon: Icons.g_mobiledata_rounded,
                                    onTap: () => _run(
                                      ref
                                          .read(authControllerProvider.notifier)
                                          .signInWithGoogle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _SocialButton(
                                    label: 'Apple',
                                    icon: Icons.apple_rounded,
                                    onTap: () => _run(
                                      ref
                                          .read(authControllerProvider.notifier)
                                          .continueAsGuest,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 24,
                        runSpacing: 8,
                        children: [
                          TextButton(
                            onPressed: () => context.go('/privacy'),
                            child: const Text('Privacy Policy'),
                          ),
                          TextButton(
                            onPressed: () => context.go('/terms'),
                            child: const Text('Terms of Service'),
                          ),
                        ],
                      ),
                      Text(
                        'BRAKSHAA 3.0 • V3.4.12-PRO',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withValues(alpha: 0.82),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.72)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Welcome back\nto the field.',
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthTabs extends StatelessWidget {
  const _AuthTabs({
    required this.signUp,
    required this.onChanged,
    this.compact = false,
  });

  final bool signUp;
  final ValueChanged<bool> onChanged;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AuthTabButton(
              label: 'Sign In',
              selected: !signUp,
              onTap: () => onChanged(false),
            ),
            SizedBox(width: compact ? 28 : 72),
            _AuthTabButton(
              label: 'Sign Up',
              selected: signUp,
              onTap: () => onChanged(true),
            ),
          ],
        ),
        if (!compact) ...[
          const SizedBox(height: 18),
          Divider(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.28)),
        ],
      ],
    );
  }
}

class _AuthTabButton extends StatelessWidget {
  const _AuthTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.titleLarge?.copyWith(
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: selected ? 7 : 0,
              height: 7,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(58),
        foregroundColor: theme.colorScheme.onSurface,
        backgroundColor: Colors.white.withValues(alpha: 0.42),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.72)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
