import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// Semantic context indicators mapping to colors.
enum DkSnackbarVariant {
  /// Information state mapping to blue/info palettes.
  info,

  /// Success state mapping to green/success palettes.
  success,

  /// Warning state mapping to orange/warning palettes.
  warning,

  /// Error state mapping to red/error palettes natively.
  error,
}

/// A factory class for rendering standardized, semantically structured
/// snackbars.
abstract final class DkSnackbar {
  /// Creates the raw [SnackBar] instance securely decoupled for testability.
  static SnackBar build({
    required String message,
    required ColorScheme colorScheme,
    required DkSemanticColors semanticColors,
    DkSnackbarVariant variant = DkSnackbarVariant.info,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    final backgroundColor = switch (variant) {
      DkSnackbarVariant.info => semanticColors.info,
      DkSnackbarVariant.success => semanticColors.success,
      DkSnackbarVariant.warning => semanticColors.warning,
      DkSnackbarVariant.error => colorScheme.error,
    };

    final foregroundColor = switch (variant) {
      DkSnackbarVariant.info => semanticColors.onInfo,
      DkSnackbarVariant.success => semanticColors.onSuccess,
      DkSnackbarVariant.warning => semanticColors.onWarning,
      DkSnackbarVariant.error => colorScheme.onError,
    };

    return SnackBar(
      backgroundColor: backgroundColor,
      duration: duration,
      action: action,
      content: Text(
        message,
        style: TextStyle(color: foregroundColor),
      ),
    );
  }

  /// Extracts theme constraints and propagates a snackbar presentation to the
  /// scaffold.
  static void show({
    required BuildContext context,
    required String message,
    DkSnackbarVariant variant = DkSnackbarVariant.info,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    final theme = Theme.of(context);
    final semanticColors =
        theme.extension<DkSemanticColors>() ??
        DkSemanticColors.fallback(theme.brightness);

    final snackbar = build(
      message: message,
      colorScheme: theme.colorScheme,
      semanticColors: semanticColors,
      variant: variant,
      action: action,
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
