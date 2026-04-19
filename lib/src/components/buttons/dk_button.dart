import 'package:flutter/material.dart';

enum _DkButtonType { filled, text, outlined }

/// A highly accessible, theme-agnostic button component wrapping Material 3.
/// Inherits sizing, typography and colors from [Theme.of(context)].
class DkButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // EAA / WCAG requires minimum 44x44 points touch target area.
    const minimumConstraints = BoxConstraints(
      minWidth: 44,
      minHeight: 44,
    );

    final effectiveOnPressed = isLoading ? null : onPressed;

    final content = isLoading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : label;

    return Semantics(
      button: true,
      enabled: effectiveOnPressed != null,
      child: ConstrainedBox(
        constraints: minimumConstraints,
        child: switch (_type) {
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
      ),
    );
  }
}
