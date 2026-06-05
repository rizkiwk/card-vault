import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// CardVault brand mark: two cards fanned behind a gradient "vault" shield
/// whose interior forms a subtle "V". Vector port of the design-system
/// `VaultMark` (100×100 viewBox). Brand-neutral — no franchise art.
class VaultMark extends StatelessWidget {
  const VaultMark({super.key, this.size = 96, this.mono});

  final double size;

  /// When set, the whole mark renders flat in this color (themed/monochrome).
  final Color? mono;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _VaultPainter(mono)),
    );
  }
}

class _VaultPainter extends CustomPainter {
  _VaultPainter(this.mono);
  final Color? mono;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 100, size.height / 100);

    // ---- fanned back cards (rounded rects rotated about the centre) ----
    void card(double deg, Color color) {
      canvas.save();
      canvas.translate(50, 50);
      canvas.rotate(deg * math.pi / 180);
      canvas.translate(-50, -50);
      final rrect = RRect.fromRectAndRadius(
        const Rect.fromLTWH(33, 26, 34, 50),
        const Radius.circular(8),
      );
      canvas.drawRRect(rrect, Paint()..color = color);
      canvas.restore();
    }

    card(
      -17,
      (mono ?? AppColors.indigo).withValues(alpha: mono != null ? 0.35 : 0.30),
    );
    card(
      15,
      (mono ?? AppColors.violet).withValues(alpha: mono != null ? 0.55 : 0.42),
    );

    // ---- front shield (forms the "V") ----
    final shield = Path()
      ..moveTo(32, 31)
      ..quadraticBezierTo(32, 25, 38, 25)
      ..lineTo(62, 25)
      ..quadraticBezierTo(68, 25, 68, 31)
      ..lineTo(68, 57)
      ..quadraticBezierTo(68, 63, 63, 67)
      ..lineTo(52, 77)
      ..quadraticBezierTo(50, 79, 48, 77)
      ..lineTo(37, 67)
      ..quadraticBezierTo(32, 63, 32, 57)
      ..close();

    final shieldPaint = Paint();
    if (mono != null) {
      shieldPaint.color = mono!;
    } else {
      shieldPaint.shader = AppColors.primaryGradient
          .createShader(const Rect.fromLTWH(20, 14, 60, 72));
    }
    canvas.drawPath(shield, shieldPaint);

    // ---- "V" highlight stroke (hidden in mono) ----
    if (mono == null) {
      final v = Path()
        ..moveTo(43, 44)
        ..lineTo(50, 58)
        ..lineTo(57, 44);
      canvas.drawPath(
        v,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.2
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.white.withValues(alpha: 0.92),
      );
    }
  }

  @override
  bool shouldRepaint(_VaultPainter oldDelegate) => oldDelegate.mono != mono;
}

/// Horizontal logo lockup: the mark + "Card" + gradient "Vault" wordmark.
class VaultLockup extends StatelessWidget {
  const VaultLockup({super.key, this.markSize = 32, this.fontSize = 22});

  final double markSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        VaultMark(size: markSize),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            children: [
              TextSpan(text: 'Card', style: TextStyle(color: onSurface)),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.primaryGradient.createShader(b),
                  child: Text(
                    'Vault',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
