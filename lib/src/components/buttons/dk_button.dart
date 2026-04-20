import 'package:flutter/material.dart';

enum _DkButtonType { filled, text, outlined }

/// A highly accessible, theme-agnostic button component wrapping Material 3.
/// Inherits sizing, typography and colors from [Theme.of(context)].
class DkButton extends StatefulWidget {
  /// Internal constructor for standardizing buttons.
  const DkButton._({
    required this.label,
    required _DkButtonType type,
    this.onPressed,
    this.isLoading = false,
  }) : _type = type;

  /// A filled button to represent the primary action.
  const DkButton.filled({
    required Widget label,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) : this._(
         label: label,
         type: _DkButtonType.filled,
         onPressed: onPressed,
         isLoading: isLoading,
       );

  /// A text button typically used for less prominent actions.
  const DkButton.text({
    required Widget label,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) : this._(
         label: label,
         type: _DkButtonType.text,
         onPressed: onPressed,
         isLoading: isLoading,
       );

  /// An outlined button representing secondary actions.
  const DkButton.outlined({
    required Widget label,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) : this._(
         label: label,
         type: _DkButtonType.outlined,
         onPressed: onPressed,
         isLoading: isLoading,
       );

  /// The main content of the button, keeping it localized
  /// and language agnostic.
  final Widget label;

  /// The callback that is called when the button is tapped.
  final VoidCallback? onPressed;

  /// If true, a loading indicator is shown and [onPressed] is deactivated.
  final bool isLoading;

  final _DkButtonType _type;

  @override
  State<DkButton> createState() => _DkButtonState();
}

class _DkButtonState extends State<DkButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.isLoading || widget.onPressed == null) return;
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.isLoading || widget.onPressed == null) return;
    setState(() => _isPressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (widget.isLoading || widget.onPressed == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    // EAA / WCAG requires minimum 44x44 points touch target area.
    const minimumConstraints = BoxConstraints(
      minWidth: 44,
      minHeight: 44,
    );

    // Using dummy function so internal Material Button doesn't invoke
    // the action, as we are handling the invocation exclusively
    // through our own GestureDetector.
    final effectiveOnPressed = (widget.isLoading || widget.onPressed == null)
        ? null
        : () {};
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    final content = widget.isLoading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : widget.label;

    final theme = Theme.of(context);
    final buttonCore = ConstrainedBox(
      constraints: minimumConstraints,
      child: switch (widget._type) {
        _DkButtonType.filled => FilledButton(
          onPressed: effectiveOnPressed,
          child: content,
        ),
        _DkButtonType.text => TextButton(
          onPressed: effectiveOnPressed,
          child: content,
        ),
        _DkButtonType.outlined => OutlinedButton(
          onPressed: effectiveOnPressed,
          child: content,
        ),
      },
    );

    return Semantics(
      button: true,
      enabled: widget.onPressed != null && !widget.isLoading,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: (widget.onPressed != null && !widget.isLoading)
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: AnimatedScale(
            scale: _isPressed && !disableAnimations ? 0.95 : 1.0,
            duration: disableAnimations
                ? Duration.zero
                : const Duration(milliseconds: 150),
            curve: Curves.easeOutBack,
            child: AnimatedContainer(
              duration: disableAnimations
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  if (_isHovered &&
                      !_isPressed &&
                      widget._type == _DkButtonType.filled)
                    BoxShadow(
                      color: theme.colorScheme.primary.withAlpha(60),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: AbsorbPointer(
                child: ExcludeSemantics(
                  child: buttonCore,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
