import 'package:design_kit/src/components/layout/dk_glass_container.dart';
import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A circular icon button with a premium glassmorphism effect.
class DkGlassIconButton extends StatefulWidget {
  /// Creates a glass icon button.
  const DkGlassIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
  });

  /// The icon to display.
  final Widget icon;

  /// Signature for when the button is tapped.
  final VoidCallback? onPressed;

  /// Accessibility tooltip.
  final String? tooltip;

  @override
  State<DkGlassIconButton> createState() => _DkGlassIconButtonState();
}

class _DkGlassIconButtonState extends State<DkGlassIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.extension<DkSpacing>() ?? const DkSpacing();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: Tooltip(
            message: widget.tooltip ?? '',
            child: Semantics(
              button: true,
              enabled: widget.onPressed != null,
              child: DkGlassContainer(
                blur: 12,
                opacity: _isHovered ? 0.2 : 0.1,
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: EdgeInsets.all(spacing.md),
                  child: IconTheme.merge(
                    data: IconThemeData(
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                    child: widget.icon,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
