import 'dart:ui';
import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A premium container that implements a glassmorphism effect.
///
/// Uses [BackdropFilter] for desaturating and blurring the background.
class DkGlassContainer extends StatelessWidget {
  /// Creates a glassmorphism container.
  const DkGlassContainer({
    required this.child,
    super.key,
    this.blur = 10.0,
    this.opacity = 0.1,
    this.borderRadius,
    this.borderWidth = 1.0,
  });

  /// The child widget to be rendered over the glass effect.
  final Widget child;

  /// The intensity of the background blur.
  final double blur;

  /// The opacity of the surface color overlay.
  final double opacity;

  /// The border radius of the container.
  final BorderRadius? borderRadius;

  /// The thickness of the glass border.
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radii = theme.extension<DkRadii>() ?? const DkRadii();
    final effectiveRadius = borderRadius ?? radii.md;

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withAlpha((opacity * 255).round()),
            borderRadius: effectiveRadius,
            border: Border.all(
              color: theme.colorScheme.onSurface.withAlpha(25),
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
