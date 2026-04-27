import 'package:design_kit/src/theme/dk_brand_theme.dart';
import 'package:design_kit/src/theme/dk_theme.dart';
import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:design_kit/src/theme/dk_typography.dart';
import 'package:flutter/material.dart';

/// Reference implementation of [DkBrandTheme] for Biome.
///
/// Rounded radii and generous spacing communicate approachability and
/// modernity — contrasting deliberately with AcmeBrandTheme's rigidity.
final class BiomeBrandTheme implements DkBrandTheme {
  /// Creates the Biome brand theme implementation.
  const BiomeBrandTheme();

  static const _seed = Color(0xFF00C896);

  @override
  ThemeData light() => DkTheme.build(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: _seed),
    textTheme: DkTypography.buildTextTheme(
      fontFamily: 'Inter',
      displayColor: const Color(0xFF004D3A),
      bodyColor: const Color(0xFF1A1A1A),
    ),
    radii: const DkRadii(
      sm: BorderRadius.all(Radius.circular(8)),
      md: BorderRadius.all(Radius.circular(16)),
      lg: BorderRadius.all(Radius.circular(24)),
    ),
    spacing: const DkSpacing(md: 20, lg: 28),
  );

  @override
  ThemeData dark() => DkTheme.build(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ),
    textTheme: DkTypography.buildTextTheme(
      fontFamily: 'Inter',
      displayColor: const Color(0xFF80FFDA),
      bodyColor: const Color(0xFFE0E0E0),
    ),
    radii: const DkRadii(
      sm: BorderRadius.all(Radius.circular(8)),
      md: BorderRadius.all(Radius.circular(16)),
      lg: BorderRadius.all(Radius.circular(24)),
    ),
    spacing: const DkSpacing(md: 20, lg: 28),
  );
}
