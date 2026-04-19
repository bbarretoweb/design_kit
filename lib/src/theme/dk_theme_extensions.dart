import 'dart:ui';
import 'package:design_kit/design_kit.dart' show DkTheme;
import 'package:design_kit/src/theme/dk_theme.dart' show DkTheme;
import 'package:flutter/material.dart';

/// Semantic colors for [DkTheme] extending beyond Material 3 defaults.
class DkSemanticColors extends ThemeExtension<DkSemanticColors> {
  /// Creates an instance of [DkSemanticColors].
  const DkSemanticColors({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
  });

  /// Fallback generation based on a brightness if not provided.
  factory DkSemanticColors.fallback(Brightness brightness) {
    return brightness == Brightness.light
        ? const DkSemanticColors(
            success: Color(0xFF2E7D32),
            onSuccess: Color(0xFFFFFFFF),
            warning: Color(0xFFED6C02),
            onWarning: Color(0xFFFFFFFF),
            info: Color(0xFF0288D1),
            onInfo: Color(0xFFFFFFFF),
          )
        : const DkSemanticColors(
            success: Color(0xFF81C784),
            onSuccess: Color(0xFF000000),
            warning: Color(0xFFFFB74D),
            onWarning: Color(0xFF000000),
            info: Color(0xFF4FC3F7),
            onInfo: Color(0xFF000000),
          );
  }

  /// Color for success state objects.
  final Color success;

  /// Color for elements placed on top of success color.
  final Color onSuccess;

  /// Color for warning state objects.
  final Color warning;

  /// Color for elements placed on top of warning color.
  final Color onWarning;

  /// Color for info state objects.
  final Color info;

  /// Color for elements placed on top of info color.
  final Color onInfo;

  @override
  DkSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
  }) {
    return DkSemanticColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  DkSemanticColors lerp(ThemeExtension<DkSemanticColors>? other, double t) {
    if (other is! DkSemanticColors) return this;
    return DkSemanticColors(
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      info: Color.lerp(info, other.info, t) ?? info,
      onInfo: Color.lerp(onInfo, other.onInfo, t) ?? onInfo,
    );
  }
}

/// Spacing foundation tokens for continuous spatial layout.
class DkSpacing extends ThemeExtension<DkSpacing> {
  /// Creates an instance of [DkSpacing].
  const DkSpacing({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
  });

  /// Extra small spacing (4.0).
  final double xs;

  /// Small spacing (8.0).
  final double sm;

  /// Medium spacing (16.0).
  final double md;

  /// Large spacing (24.0).
  final double lg;

  /// Extra large spacing (32.0).
  final double xl;

  /// Double extra large spacing (48.0).
  final double xxl;

  @override
  DkSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return DkSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  DkSpacing lerp(ThemeExtension<DkSpacing>? other, double t) {
    if (other is! DkSpacing) return this;
    return DkSpacing(
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
    );
  }
}

/// Border radius foundational tokens.
class DkRadii extends ThemeExtension<DkRadii> {
  /// Creates an instance of [DkRadii].
  const DkRadii({
    this.sm = const BorderRadius.all(Radius.circular(4)),
    this.md = const BorderRadius.all(Radius.circular(8)),
    this.lg = const BorderRadius.all(Radius.circular(16)),
    this.pill = const BorderRadius.all(Radius.circular(999)),
  });

  /// Small border radius.
  final BorderRadius sm;

  /// Medium border radius.
  final BorderRadius md;

  /// Large border radius.
  final BorderRadius lg;

  /// Pill shaped border radius.
  final BorderRadius pill;

  @override
  DkRadii copyWith({
    BorderRadius? sm,
    BorderRadius? md,
    BorderRadius? lg,
    BorderRadius? pill,
  }) {
    return DkRadii(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      pill: pill ?? this.pill,
    );
  }

  @override
  DkRadii lerp(ThemeExtension<DkRadii>? other, double t) {
    if (other is! DkRadii) return this;
    return DkRadii(
      sm: BorderRadius.lerp(sm, other.sm, t) ?? sm,
      md: BorderRadius.lerp(md, other.md, t) ?? md,
      lg: BorderRadius.lerp(lg, other.lg, t) ?? lg,
      pill: BorderRadius.lerp(pill, other.pill, t) ?? pill,
    );
  }
}
