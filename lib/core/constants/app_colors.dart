import 'package:flutter/material.dart';

/// Lemonaide brand palette — light and dark variants.
abstract final class AppColors {
  // Brand (shared)
  static const lemonYellow = Color(0xFFFFE66D);
  static const pastelYellow = Color(0xFFFFF4A6);
  static const blue = Color(0xFF7CC7F7);
  static const skyBlue = Color(0xFFBEE3FF);
  static const mintGreen = Color(0xFFE6F7C9);
  static const slate = Color(0xFF4A5A6A);

  // Light theme
  static const cream = Color(0xFFFFFDF7);
  static const creamSurface = Color(0xFFFFFFFF);
  static const lightShadow = Color(0x1A4A5A6A);

  // Dark theme
  static const darkBackground = Color(0xFF1A2332);
  static const darkSurface = Color(0xFF243044);
  static const darkSurfaceHigh = Color(0xFF2E3D52);
  static const darkCream = Color(0xFFE8E4DC);
  static const darkShadow = Color(0x40000000);

  static ColorScheme lightScheme() => const ColorScheme(
        brightness: Brightness.light,
        primary: blue,
        onPrimary: cream,
        secondary: lemonYellow,
        onSecondary: slate,
        tertiary: mintGreen,
        onTertiary: slate,
        error: Color(0xFFE57373),
        onError: cream,
        surface: cream,
        onSurface: slate,
        surfaceContainerHighest: creamSurface,
        outline: skyBlue,
        outlineVariant: pastelYellow,
      );

  static ColorScheme darkScheme() => const ColorScheme(
        brightness: Brightness.dark,
        primary: blue,
        onPrimary: darkBackground,
        secondary: lemonYellow,
        onSecondary: darkBackground,
        tertiary: mintGreen,
        onTertiary: darkBackground,
        error: Color(0xFFEF9A9A),
        onError: darkBackground,
        surface: darkBackground,
        onSurface: darkCream,
        surfaceContainerHighest: darkSurface,
        outline: Color(0xFF5A7A9A),
        outlineVariant: Color(0xFF3D5268),
      );
}
