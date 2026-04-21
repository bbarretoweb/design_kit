import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A static, read-only visual indicator used for displaying properties
/// like a technology stack or object status.
///
/// Unlike `DkChip`, which is interactive and requires touch constraints,
/// this component exists purely for displaying informational properties.
class DkTag extends StatelessWidget {
  /// Defines a stylistic semantic tag.
  const DkTag({
    required this.label,
    super.key,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  /// The text content to display.
  final String label;

  /// Optional icon to display to the left of the label.
  final Widget? icon;

  /// Background color of the tag. Falls back to [ColorScheme.primaryContainer].
  final Color? backgroundColor;

  /// Text color. Falls back to [ColorScheme.onPrimaryContainer].
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radii = theme.extension<DkRadii>() ?? const DkRadii();
    final spacing = theme.extension<DkSpacing>() ?? const DkSpacing();

    final bg = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fg = textColor ?? theme.colorScheme.onPrimaryContainer;

    return Semantics(
      label: label,
      readOnly: true,
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radii.pill,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.sm,
            vertical: spacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                IconTheme.merge(
                  data: IconThemeData(
                    size: 16,
                    color: fg,
                  ),
                  child: icon!,
                ),
                SizedBox(width: spacing.xs),
              ],
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
