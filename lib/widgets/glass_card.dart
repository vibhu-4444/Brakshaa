import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.radius = BrakshaaSpacing.cardRadius,
    this.borderColor,
    this.gradient,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color? borderColor;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveGradient = gradient ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (isDark ? Colors.white : Colors.white).withValues(alpha: isDark ? 0.08 : 0.72),
            colorScheme.primary.withValues(alpha: isDark ? 0.08 : 0.035),
            BrakshaaColors.gold.withValues(alpha: isDark ? 0.06 : 0.025),
          ],
        );

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  gradient: effectiveGradient,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: borderColor ??
                        (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.82)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.045),
                      blurRadius: 30,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
