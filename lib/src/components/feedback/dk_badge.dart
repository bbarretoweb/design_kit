import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A notification badge that overlays a child widget with a count or dot
/// indicator. Follows WCAG parameters and reads styling dynamically from the
/// active [Theme].
class DkBadge extends StatelessWidget {
  /// Defines a semantic badge container overlaying a [child].
  const DkBadge({
    required this.child,
    super.key,
    this.count,
    this.color,
    this.textColor,
  });

  /// The widget that the badge will be applied to.
  final Widget child;

  /// The number to display in the badge.
  /// If null, a small dot indicator (8px circle) is rendered.
  /// If 0, the badge is completely hidden.
  final int? count;

  /// The background color of the badge. Defaults to [ColorScheme.error].
  final Color? color;

  /// The text color of the badge. Defaults to [ColorScheme.onError].
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return child;
    }

    final theme = Theme.of(context);
    final radii = theme.extension<DkRadii>() ?? const DkRadii();
    final spacing = theme.extension<DkSpacing>() ?? const DkSpacing();

    final backgroundColor = color ?? theme.colorScheme.error;
    final foregroundColor = textColor ?? theme.colorScheme.onError;

    // Dot mode
    if (count == null) {
      return Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          child,
          Positioned(
            top: 0,
            right: 0,
            child: Semantics(
              label: 'Unread notification',
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Number mode
    final displayCount = count! > 99 ? '99+' : count.toString();

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child,
        Positioned(
          top: -spacing.xs,
          right: -spacing.xs,
          child: Semantics(
            label: '$count',
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.xs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: radii.pill,
              ),
              child: Text(
                displayCount,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
