import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Circular FAB filled with the primary gradient and a soft colored glow.
class GradientFab extends StatelessWidget {
  const GradientFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip,
    this.gradient = AppColors.primaryGradient,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: gradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.indigo.withValues(alpha: 0.40),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

/// Pill button filled with the primary (or accent) gradient.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.accent = false,
    this.expand = true,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool accent;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final gradient =
        accent ? AppColors.accentGradient : AppColors.primaryGradient;
    final fg = accent ? AppColors.onAccent : Colors.white;
    final enabled = onPressed != null;

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(999),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: (accent ? AppColors.accentStart : AppColors.indigo)
                        .withValues(alpha: 0.34),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 52,
              width: expand ? double.infinity : null,
              padding: EdgeInsets.symmetric(horizontal: expand ? 0 : 24),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: fg, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: fg,
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
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
