import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// Factory class for building the fully loaded [ThemeData] for the design kit.
class DkTheme {
  /// Builds a [ThemeData] instance with [ColorScheme],
  /// [TextTheme] and extensions.
  /// Uses [colorScheme] directly and ensures full in-version of control.
  static ThemeData build({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    DkSemanticColors? semanticColors,
    DkSpacing? spacing,
    DkRadii? radii,
  }) {
    // Generate fallbacks if extensions are not provided.
    final safeSemanticColors =
        semanticColors ?? DkSemanticColors.fallback(brightness);
    final safeSpacing = spacing ?? const DkSpacing();
    final safeRadii = radii ?? const DkRadii();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        safeSemanticColors,
        safeSpacing,
        safeRadii,
      ],
    );
  }
}
