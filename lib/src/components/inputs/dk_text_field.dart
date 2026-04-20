import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// A heavily adapted text field component wrapping Material 3 [TextFormField].
/// Respects accessibility, supports dynamic theming and uses [DkRadii] for
/// shapes.
class DkTextField extends StatelessWidget {
  /// Defines a scalable semantic text input.
  const DkTextField({
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.maxLines,
  });

  /// Optional controller to manage the text being edited.
  final TextEditingController? controller;

  /// Semantic hint explaining what information is requested.
  final String? hintText;

  /// External error message (support for external
  /// unhardcoded i18n validations).
  final String? errorText;

  /// Hides text for sensitive inputs like passwords.
  final bool obscureText;

  /// The type of keyboard to use.
  final TextInputType? keyboardType;

  /// The action the keyboard should take upon completion.
  final TextInputAction? textInputAction;

  /// Provides changes of the text input.
  final ValueChanged<String>? onChanged;

  /// The maximum number of lines the text field can have.
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radii = theme.extension<DkRadii>() ?? const DkRadii();

    // Default touch surface minimum requirements matching 44px
    const minimumConstraints = BoxConstraints(
      minHeight: 44,
      minWidth: 44,
    );

    return ConstrainedBox(
      constraints: minimumConstraints,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        maxLines: obscureText ? 1 : maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          border: OutlineInputBorder(
            borderRadius: radii.md,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: radii.md,
            borderSide: BorderSide(
              color: theme.colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radii.md,
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: radii.md,
            borderSide: BorderSide(
              color: theme.colorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: radii.md,
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          // Padding matching spacing fundamentals
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
