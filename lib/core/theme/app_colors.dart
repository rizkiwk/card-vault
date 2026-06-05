import 'package:flutter/material.dart';

/// CardVault "gradient direction" design tokens.
///
/// Electric indigo → violet primary gradient with a fresh teal accent.
/// Gradients are used sparingly (hero surfaces, FAB, primary buttons, selected
/// chips); body content sits on flat neutral surfaces. Mirrors the design
/// system `redesign/tokens.css`.
class AppColors {
  AppColors._();

  // ---- Brand gradient stops ----
  static const indigo = Color(0xFF4254FF);
  static const violet = Color(0xFF7A3DFF);
  static const accentStart = Color(0xFF00D1B2);
  static const accentEnd = Color(0xFF19E3C3);

  /// 135° primary gradient (top-left → bottom-right).
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [indigo, violet],
  );

  /// Teal accent gradient — positive / gain states.
  static const accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentStart, accentEnd],
  );

  // ---- Light ----
  static const lightBg = Color(0xFFF7F8FC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurface2 = Color(0xFFF1F3FA);
  static const lightOutline = Color(0xFFE7E9F2);
  static const lightOnBg = Color(0xFF14161C);
  static const lightMuted = Color(0xFF5B6172);
  static const lightMuted2 = Color(0xFF8A90A2);
  static const lightIndigo = Color(0xFF4254FF);
  static const lightGain = Color(0xFF00B89C);
  static const lightLoss = Color(0xFFFF5A6E);

  // ---- Dark ----
  static const darkBg = Color(0xFF0E1116);
  static const darkSurface = Color(0xFF171B22);
  static const darkSurface2 = Color(0xFF1E232C);
  static const darkOutline = Color(0xFF262C37);
  static const darkOnBg = Color(0xFFEEF0F6);
  static const darkMuted = Color(0xFF9AA0B2);
  static const darkMuted2 = Color(0xFF6B7180);
  static const darkIndigo = Color(0xFF8A95FF);
  static const darkGain = Color(0xFF19E3C3);
  static const darkLoss = Color(0xFFFF7A88);

  // ---- Shared semantic ----
  static const favorite = Color(0xFFFFC24B);
  static const warning = Color(0xFFFFB020);
  static const onAccent = Color(0xFF04261F);
}

/// Theme-aware accessors for tokens that differ between light and dark.
/// `Theme.of(context).extension<AppPalette>()`.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.gain,
    required this.loss,
    required this.muted,
    required this.surface2,
    required this.onPrimaryGradient,
  });

  final Color gain;
  final Color loss;
  final Color muted;
  final Color surface2;
  final Color onPrimaryGradient;

  static const light = AppPalette(
    gain: AppColors.lightGain,
    loss: AppColors.lightLoss,
    muted: AppColors.lightMuted,
    surface2: AppColors.lightSurface2,
    onPrimaryGradient: Colors.white,
  );

  static const dark = AppPalette(
    gain: AppColors.darkGain,
    loss: AppColors.darkLoss,
    muted: AppColors.darkMuted,
    surface2: AppColors.darkSurface2,
    onPrimaryGradient: Colors.white,
  );

  @override
  AppPalette copyWith({
    Color? gain,
    Color? loss,
    Color? muted,
    Color? surface2,
    Color? onPrimaryGradient,
  }) {
    return AppPalette(
      gain: gain ?? this.gain,
      loss: loss ?? this.loss,
      muted: muted ?? this.muted,
      surface2: surface2 ?? this.surface2,
      onPrimaryGradient: onPrimaryGradient ?? this.onPrimaryGradient,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      gain: Color.lerp(gain, other.gain, t)!,
      loss: Color.lerp(loss, other.loss, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      onPrimaryGradient:
          Color.lerp(onPrimaryGradient, other.onPrimaryGradient, t)!,
    );
  }
}

/// Convenience getter.
extension AppPaletteX on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
