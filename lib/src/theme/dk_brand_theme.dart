import 'package:flutter/material.dart';

/// An abstract contract for brand-specific theme configurations.
///
/// Each product or client creates a concrete implementation, injecting
/// brand-specific values into `DkTheme.build` without touching the
/// design_kit source. This is the explicit IoC boundary between the
/// engine (design_kit) and the brand (host app or brand package).
abstract class DkBrandTheme {
  /// Returns the light-mode [ThemeData] for this brand.
  ThemeData light();

  /// Returns the dark-mode [ThemeData] for this brand.
  ThemeData dark();
}
