import 'package:design_kit/src/theme/dk_theme_extensions.dart';
import 'package:flutter/material.dart';

/// Visual variants dictating the appropriate material chip implementation.
enum DkChipVariant {
  /// Equivalent to a standard toggleable [FilterChip].
  filter,

  /// Equivalent to an [InputChip] which captures values or triggers an action,
  /// usually with a deletion callback.
  input,

  /// Equivalent to an [ActionChip] for one-off semantic actions.
  suggestion,
}

/// A compact, interactive label component for tags, filters, or selections.
/// Adapts shape and touch sizes to accessible parameters.
class DkChip extends StatelessWidget {
  /// Defines a semantic chip using the desired [variant].
  const DkChip({
    required this.label,
    super.key,
    this.variant = DkChipVariant.suggestion,
    this.selected = false,
    this.onPressed,
    this.onDeleted,
    this.avatar,
  });

  /// The primary content of the chip.
  final Widget label;

  /// The variant specifying the behavior of the chip.
  final DkChipVariant variant;

  /// Whether or not this chip is currently selected.
  final bool selected;

  /// Triggered when the user taps on the chip.
  final VoidCallback? onPressed;

  /// Triggered when the user deletes the chip.
  final VoidCallback? onDeleted;

  /// An optional leading widget.
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    const minimumConstraints = BoxConstraints(
      minHeight: 44,
      minWidth: 44,
    );

    final theme = Theme.of(context);
    final radii = theme.extension<DkRadii>() ?? const DkRadii();

    final shape = RoundedRectangleBorder(
      borderRadius: radii.pill,
    );

    final Widget chip;

    switch (variant) {
      case DkChipVariant.suggestion:
        chip = ActionChip(
          label: label,
          onPressed: onPressed,
          avatar: avatar,
          shape: shape,
        );
      case DkChipVariant.filter:
        chip = FilterChip(
          label: label,
          selected: selected,
          onSelected: (_) => onPressed?.call(),
          avatar: avatar,
          shape: shape,
        );
      case DkChipVariant.input:
        chip = InputChip(
          label: label,
          onPressed: onPressed,
          onDeleted: onDeleted,
          avatar: avatar,
          shape: shape,
        );
    }

    return ConstrainedBox(
      constraints: minimumConstraints,
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: chip,
      ),
    );
  }
}
