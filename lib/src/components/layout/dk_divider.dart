import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A semantic horizontal or vertical divider with an optional descriptive
/// label.
class DkDivider extends StatelessWidget {
  /// Distributes spatial separation via [axis] and styling configuration.
  const DkDivider({
    super.key,
    this.label,
    this.axis = Axis.horizontal,
    this.thickness = 1.0,
    this.indent,
    this.endIndent,
  });

  /// An optional text widget injected centrally across the lines.
  final Widget? label;

  /// Directionality of the split.
  final Axis axis;

  /// Physical representation thickness of the divider lines.
  final double thickness;

  /// Margins at the leading bounds of the divider component.
  final double? indent;

  /// Margins at the trailing bounds of the divider component.
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.extension<DkSpacing>() ?? const DkSpacing();

    final safeIndent = indent ?? spacing.md;
    final safeEndIndent = endIndent ?? spacing.md;
    final color = theme.colorScheme.outlineVariant;

    final Widget dividerWidget;

    if (axis == Axis.horizontal) {
      dividerWidget = Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: color,
              thickness: thickness,
              indent: 0,
              endIndent: 0,
            ),
          ),
          if (label != null) ...[
            SizedBox(width: spacing.sm),
            label!,
            SizedBox(width: spacing.sm),
            Expanded(
              child: Divider(
                color: color,
                thickness: thickness,
                indent: 0,
                endIndent: 0,
              ),
            ),
          ],
        ],
      );
    } else {
      dividerWidget = Column(
        children: <Widget>[
          Expanded(
            child: VerticalDivider(
              color: color,
              thickness: thickness,
              indent: safeIndent,
              endIndent: label != null ? spacing.sm : 0,
            ),
          ),
          if (label != null) ...[
            Flexible(child: label!),
            Expanded(
              child: VerticalDivider(
                color: color,
                thickness: thickness,
                indent: spacing.sm,
                endIndent: safeEndIndent,
              ),
            ),
          ],
        ],
      );
    }

    // Special case for horizontal divider without label: use a single
    // Divider widget
    if (label == null && axis == Axis.horizontal) {
      return Divider(
        color: color,
        thickness: thickness,
        indent: safeIndent,
        endIndent: safeEndIndent,
      );
    }

    // Special case for vertical divider without label: use a single
    // VerticalDivider widget
    if (label == null && axis == Axis.vertical) {
      return VerticalDivider(
        color: color,
        thickness: thickness,
        indent: safeIndent,
        endIndent: safeEndIndent,
      );
    }

    // For labeled dividers, apply indent/endIndent as outer padding so the
    // entire component (lines + label) is inset symmetrically.
    final outerPadding = axis == Axis.horizontal
        ? EdgeInsets.only(left: safeIndent, right: safeEndIndent)
        : EdgeInsets.only(top: safeIndent, bottom: safeEndIndent);

    return Padding(padding: outerPadding, child: dividerWidget);
  }
}
