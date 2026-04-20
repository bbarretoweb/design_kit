import 'package:design_kit/src/components/display/dk_tag.dart';
import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A fundamental card component displaying rich content for portfolio projects.
///
/// Designed to compose imagery, headings, descriptions, tag groupings, and
/// interactive actions in a semantically dense block. Implements structural
/// styling logic dictated by [Theme] and [DkRadii].
class DkProjectCard extends StatefulWidget {
  /// Defines a composable project card.
  const DkProjectCard({
    required this.title,
    this.heroImage,
    this.subtitle,
    this.description,
    this.tags = const [],
    this.callToAction,
    this.onPressed,
    this.imageSemanticLabel,
    super.key,
  });

  /// Primary image provider spanning the top area of the card.
  final ImageProvider? heroImage;

  /// Screen reader label for the [heroImage].
  final String? imageSemanticLabel;

  /// The primary project title.
  final String title;

  /// An optional one-line detail beneath the main title.
  final String? subtitle;

  /// The long-form description supporting the project details.
  final String? description;

  /// A collection of technology or categorical tags shown beneath the content.
  final List<DkTag> tags;

  /// Typically a custom interaction action.
  final Widget? callToAction;

  /// Interaction hook for treating the entire card as a tap target.
  final VoidCallback? onPressed;

  @override
  State<DkProjectCard> createState() => _DkProjectCardState();
}

class _DkProjectCardState extends State<DkProjectCard> {
  Offset? _mousePosition;

  void _handleHover(PointerEvent event) {
    setState(() => _mousePosition = event.localPosition);
  }

  void _handleExit(PointerEvent event) {
    setState(() => _mousePosition = null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radii = theme.extension<DkRadii>() ?? const DkRadii();
    final spacing = theme.extension<DkSpacing>() ?? const DkSpacing();

    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    Widget cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.heroImage != null)
          Semantics(
            image: true,
            label: widget.imageSemanticLabel ?? 'Project image',
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.heroImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              if (widget.subtitle != null && widget.subtitle!.isNotEmpty) ...[
                SizedBox(height: spacing.xs),
                Text(
                  widget.subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (widget.description != null &&
                  widget.description!.isNotEmpty) ...[
                SizedBox(height: spacing.sm),
                Text(
                  widget.description!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (widget.tags.isNotEmpty) ...[
                SizedBox(height: spacing.md),
                Wrap(
                  spacing: spacing.xs,
                  runSpacing: spacing.xs,
                  children: widget.tags,
                ),
              ],
              if (widget.callToAction != null) ...[
                SizedBox(height: spacing.md),
                widget.callToAction!,
              ],
            ],
          ),
        ),
      ],
    );

    if (widget.onPressed != null) {
      cardContent = InkWell(
        onTap: () {
          widget.onPressed?.call();
        },
        borderRadius: radii.lg,
        child: cardContent,
      );
    }

    final cardInner = Material(
      color: theme.colorScheme.surface,
      borderRadius: radii.lg,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Inner Glow effect behind content
          if (_mousePosition != null && !disableAnimations)
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final alignmentX =
                      (_mousePosition!.dx / constraints.maxWidth) * 2 - 1;
                  final alignmentY =
                      (_mousePosition!.dy / constraints.maxHeight) * 2 - 1;

                  return Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(alignmentX, alignmentY),
                        radius: 1.2,
                        colors: [
                          theme.colorScheme.primary.withAlpha(15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          // Content layered on top
          cardContent,
        ],
      ),
    );

    return MouseRegion(
      onHover: _handleHover,
      onExit: _handleExit,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate border glow coordinates
          AlignmentGeometry borderGlowCenter = Alignment.center;
          if (_mousePosition != null && !disableAnimations) {
            borderGlowCenter = Alignment(
              (_mousePosition!.dx / constraints.maxWidth) * 2 - 1,
              (_mousePosition!.dy / constraints.maxHeight) * 2 - 1,
            );
          }

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(1.5), // The "border" thickness
            decoration: BoxDecoration(
              borderRadius: radii.lg.copyWith(
                topLeft: radii.lg.topLeft + const Radius.circular(1.5),
                topRight: radii.lg.topRight + const Radius.circular(1.5),
                bottomLeft: radii.lg.bottomLeft + const Radius.circular(1.5),
                bottomRight: radii.lg.bottomRight + const Radius.circular(1.5),
              ),
              color: theme.dividerColor.withAlpha(20),
              gradient: (_mousePosition != null && !disableAnimations)
                  ? RadialGradient(
                      center: borderGlowCenter,
                      radius: 2,
                      colors: [
                        theme.colorScheme.primary.withAlpha(120),
                        theme.colorScheme.primary.withAlpha(0),
                      ],
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: cardInner, // Render the card inside
          );
        },
      ),
    );
  }
}
