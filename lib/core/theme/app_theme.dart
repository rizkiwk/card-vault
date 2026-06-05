import 'package:flutter/material.dart';

import 'app_colors.dart';

/// CardVault gradient-direction theme (light & dark).
///
/// Built from explicit tokens (not `fromSeed`) so colors match the design
/// system exactly. Plus Jakarta Sans, radii of 20/16/12, pill buttons, soft
/// elevation and flat neutral surfaces.
class AppTheme {
  AppTheme._();

  static const _font = 'PlusJakartaSans';

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.darkIndigo,
            onPrimary: Colors.white,
            secondary: AppColors.accentEnd,
            onSecondary: AppColors.onAccent,
            surface: AppColors.darkSurface,
            onSurface: AppColors.darkOnBg,
            surfaceContainerHighest: AppColors.darkSurface2,
            outline: AppColors.darkOutline,
            outlineVariant: AppColors.darkOutline,
            error: AppColors.darkLoss,
          )
        : const ColorScheme.light(
            primary: AppColors.indigo,
            onPrimary: Colors.white,
            secondary: AppColors.accentStart,
            onSecondary: AppColors.onAccent,
            surface: AppColors.lightSurface,
            onSurface: AppColors.lightOnBg,
            surfaceContainerHighest: AppColors.lightSurface2,
            outline: AppColors.lightOutline,
            outlineVariant: AppColors.lightOutline,
            error: AppColors.lightLoss,
          );

    final scaffoldBg = isDark ? AppColors.darkBg : AppColors.lightBg;
    final muted = isDark ? AppColors.darkMuted : AppColors.lightMuted;

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: _font,
      scaffoldBackgroundColor: scaffoldBg,
    );

    return base.copyWith(
      extensions: [isDark ? AppPalette.dark : AppPalette.light],
      textTheme: _textTheme(base.textTheme, scheme.onSurface, muted),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: _font,
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
        selectedColor: scheme.primary,
        side: BorderSide.none,
        shape: const StadiumBorder(),
        labelStyle: TextStyle(
          fontFamily: _font,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: scheme.onSurface,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: _font,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontFamily: _font,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withValues(alpha: isDark ? 0.28 : 0.14),
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: _font,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: muted,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outline,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base, Color onSurface, Color muted) {
    TextStyle s(double size, double height, FontWeight w, double ls) =>
        TextStyle(
          fontFamily: _font,
          fontSize: size,
          height: height / size,
          fontWeight: w,
          letterSpacing: ls,
          color: onSurface,
        );
    return base.copyWith(
      displaySmall: s(30, 36, FontWeight.w700, -0.6),
      headlineMedium: s(28, 34, FontWeight.w700, -0.5),
      headlineSmall: s(24, 30, FontWeight.w700, -0.4),
      titleLarge: s(20, 26, FontWeight.w700, -0.3),
      titleMedium: s(17, 24, FontWeight.w600, -0.2),
      titleSmall: s(15, 20, FontWeight.w600, -0.1),
      bodyLarge: s(16, 24, FontWeight.w500, 0),
      bodyMedium: s(15, 22, FontWeight.w500, 0),
      bodySmall: s(13, 18, FontWeight.w500, 0).copyWith(color: muted),
      labelLarge: s(14, 18, FontWeight.w600, 0),
      labelMedium: s(12, 16, FontWeight.w600, 0.1).copyWith(color: muted),
      labelSmall: s(12, 16, FontWeight.w600, 0.1),
    );
  }
}
