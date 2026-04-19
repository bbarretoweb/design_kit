import 'package:flutter/material.dart';

/// A factory class for building a typography foundation.
class DkTypography {
  /// Builds an M3 [TextTheme] based on specific [fontFamily],
  /// [displayColor] and [bodyColor].
  static TextTheme buildTextTheme({
    required String fontFamily,
    required Color displayColor,
    required Color bodyColor,
  }) {
    // Generate a default text theme with the given colors.
    // It is important that this returns a complete TextTheme
    // compatible with Material 3.
    final defaultTypography = Typography.material2021();

    // Choose the base text theme by default
    // (usually English-like works as a generic baseline)
    final baseTheme = defaultTypography.englishLike;

    return baseTheme.copyWith(
      displayLarge: baseTheme.displayLarge?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      displayMedium: baseTheme.displayMedium?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      displaySmall: baseTheme.displaySmall?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      headlineLarge: baseTheme.headlineLarge?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      headlineMedium: baseTheme.headlineMedium?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      headlineSmall: baseTheme.headlineSmall?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      titleLarge: baseTheme.titleLarge?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      titleMedium: baseTheme.titleMedium?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      titleSmall: baseTheme.titleSmall?.copyWith(
        fontFamily: fontFamily,
        color: displayColor,
      ),
      bodyLarge: baseTheme.bodyLarge?.copyWith(
        fontFamily: fontFamily,
        color: bodyColor,
      ),
      bodyMedium: baseTheme.bodyMedium?.copyWith(
        fontFamily: fontFamily,
        color: bodyColor,
      ),
      bodySmall: baseTheme.bodySmall?.copyWith(
        fontFamily: fontFamily,
        color: bodyColor,
      ),
      labelLarge: baseTheme.labelLarge?.copyWith(
        fontFamily: fontFamily,
        color: bodyColor,
      ),
      labelMedium: baseTheme.labelMedium?.copyWith(
        fontFamily: fontFamily,
        color: bodyColor,
      ),
      labelSmall: baseTheme.labelSmall?.copyWith(
        fontFamily: fontFamily,
        color: bodyColor,
      ),
    );
  }
}
