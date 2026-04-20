import 'package:design_kit/src/theme/dk_brand_theme.dart';
import 'package:design_kit/src/theme/dk_theme.dart';
import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:design_kit/src/theme/dk_typography.dart';
import 'package:flutter/material.dart';

/// Reference implementation of [DkBrandTheme] for Acme Corp.
///
/// Sharp radii and dense spacing communicate rigidity and institutional trust.
/// This file is an example only — host apps copy and adapt it; never modify
/// design_kit internals to accommodate a brand.
final class AcmeBrandTheme implements DkBrandTheme {
  /// Creates the Acme Corp brand theme implementation.
  const AcmeBrandTheme();

  static const _seed = Color(0xFF1B3A6B);

  @override
  ThemeData light() => DkTheme.build(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
    ),
    textTheme: DkTypography.buildTextTheme(
      fontFamily: 'Roboto',
      displayColor: const Color(0xFF1B3A6B),
      bodyColor: const Color(0xFF212121),
    ),
    radii: const DkRadii(
      sm: BorderRadius.all(Radius.circular(2)),
      md: BorderRadius.all(Radius.circular(4)),
      lg: BorderRadius.all(Radius.circular(8)),
    ),
  );

  @override
  ThemeData dark() => DkTheme.build(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ),
    textTheme: DkTypography.buildTextTheme(
      fontFamily: 'Roboto',
      displayColor: const Color(0xFFBBC8E6),
      bodyColor: const Color(0xFFE0E0E0),
    ),
    radii: const DkRadii(
      sm: BorderRadius.all(Radius.circular(2)),
      md: BorderRadius.all(Radius.circular(4)),
      lg: BorderRadius.all(Radius.circular(8)),
    ),
  );
}
