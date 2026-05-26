import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../design_system/tokens/wireframe_styles.dart';
import '../spacing/app_spacing.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(
        brightness: Brightness.light,
        colorScheme: AppColors.lightScheme(),
        scaffoldBackground: AppColors.cream,
        cardColor: AppColors.creamSurface,
        shadowColor: AppColors.lightShadow,
        navRailBackground: AppColors.creamSurface,
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        colorScheme: AppColors.darkScheme(),
        scaffoldBackground: AppColors.darkBackground,
        cardColor: AppColors.darkSurface,
        shadowColor: AppColors.darkShadow,
        navRailBackground: AppColors.darkSurface,
      );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required Color cardColor,
    required Color shadowColor,
    required Color navRailBackground,
  }) {
    final isDark = brightness == Brightness.dark;
    final baseTextTheme = AppTextStyles.textTheme(isDark: isDark);
    final textTheme = GoogleFonts.quicksandTextTheme(baseTextTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
        ),
        margin: EdgeInsets.zero,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: navRailBackground,
        indicatorColor: AppColors.skyBlue.withValues(
          alpha: isDark ? 0.35 : 0.6,
        ),
        selectedIconTheme: IconThemeData(
          color: colorScheme.primary,
          size: 28,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onSurface.withValues(alpha: 0.55),
          size: 26,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withValues(alpha: 0.3),
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurfaceHigh : AppColors.creamSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.slate,
            width: WireframeStyles.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.slate,
            width: WireframeStyles.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.slate,
            width: WireframeStyles.borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: WireframeStyles.borderWidth,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
