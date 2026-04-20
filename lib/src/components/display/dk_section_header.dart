import 'package:design_kit/src/components/layout/dk_divider.dart';
import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A structural heading primitive to visually divide pages.
///
/// Ensures clear hierarchy by combining a main title, an optional subtitle
/// (kicker), trailing actions and a visual [DkDivider]. Supports accessibility
/// by wrapping the main title with the `header` semantics flag.
class DkSectionHeader extends StatelessWidget {
  /// Creates a composable section header.
  const DkSectionHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.trailingAction,
    this.showDivider = true,
    this.alignment = CrossAxisAlignment.start,
  });

  /// The main heading text of this section.
  final String title;

  /// A smaller descriptive text rendered above the title.
  final String? subtitle;

  /// An optional trailing interactive element, typically a button.
  final Widget? trailingAction;

  /// Whether to render a horizontal [DkDivider] beneath the header.
  final bool showDivider;

  /// Horizontal alignment of the header content.
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.extension<DkSpacing>() ?? const DkSpacing();

    final textAlign = switch (alignment) {
      CrossAxisAlignment.center => TextAlign.center,
      CrossAxisAlignment.end => TextAlign.end,
      _ => TextAlign.start,
    };

    final headerContent = Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          Text(
            subtitle!,
            textAlign: textAlign,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spacing.xs),
        ],
        Semantics(
          header: true,
          child: Text(
            title,
            textAlign: textAlign,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

    final isCenter = alignment == CrossAxisAlignment.center;

    return Column(
      crossAxisAlignment: isCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: isCenter ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: isCenter
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (!isCenter) Expanded(child: headerContent) else headerContent,
            if (trailingAction != null) ...[
              SizedBox(width: spacing.md),
              trailingAction!,
            ],
          ],
        ),
        if (showDivider) ...[
          SizedBox(height: spacing.sm),
          DkDivider(
            indent: isCenter ? 64 : 0,
            endIndent: isCenter ? 64 : 0,
          ),
        ],
      ],
    );
  }
}
