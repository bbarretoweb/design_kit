import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A responsive scaling grid that collapses columns based on horizontal
/// space. Useful for creating robust content reflows (like portfolio cards)
/// without explicitly injecting sizing constraints externally.
class DkGrid extends StatelessWidget {
  /// Defines a layout wrapper distributing [children] based on width metrics.
  const DkGrid({
    required this.children,
    super.key,
  });

  /// The widgets to render inside the responsive grid constraints.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final spacing =
        Theme.of(context).extension<DkSpacing>() ?? const DkSpacing();
    final gap = spacing.md;

    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        if (width == double.infinity) {
          width = MediaQuery.sizeOf(context).width;
        }

        final int crossAxisCount;

        if (width < 600) {
          crossAxisCount = 1;
        } else if (width < 900) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 3;
        }

        if (crossAxisCount == 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1) SizedBox(height: gap),
              ],
            ],
          );
        }

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: children.map((child) {
            final totalGapSpace = gap * (crossAxisCount - 1);
            final childWidth = (width - totalGapSpace) / crossAxisCount;
            // Provide a small buffer to prevent precision issues forcing wrap.
            return SizedBox(
              width: childWidth - 0.1,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}
