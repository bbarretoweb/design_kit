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
  });

  /// An optional text widget injected centrally across the lines.
  final Widget? label;

  /// Directionality of the split.
  final Axis axis;

  /// Physical representation thickness of the divider lines.
  final double thickness;

  /// Margins at the trailing and leading bounds of the divider component.
  final double? indent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.extension<DkSpacing>() ?? const DkSpacing();

    final safeIndent = indent ?? spacing.md;
    final color = theme.colorScheme.outlineVariant;

    final Widget dividerWidget;

    if (axis == Axis.horizontal) {
      dividerWidget = Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: color,
              thickness: thickness,
              indent: safeIndent,
              endIndent: label != null ? spacing.sm : safeIndent,
            ),
          ),
          ?label,
          Expanded(
            child: Divider(
              color: color,
              thickness: thickness,
              indent: label != null ? spacing.sm : 0,
              endIndent: safeIndent,
            ),
          ),
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
              endIndent: label != null ? spacing.sm : safeIndent,
            ),
          ),
          ?label,
          Expanded(
            child: VerticalDivider(
              color: color,
              thickness: thickness,
              indent: label != null ? spacing.sm : 0,
              endIndent: safeIndent,
            ),
          ),
        ],
      );
    }

    return dividerWidget;
  }
}
