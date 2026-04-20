import 'package:flutter/material.dart';

/// An accessible, themed toggle switch enforcing sizing boundaries.
class DkSwitch extends StatelessWidget {
  /// Defines a dual-state boolean toggle with semantic label associations.
  const DkSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.label,
    this.semanticLabel,
  });

  /// Current logical state of the switch.
  final bool value;

  /// Mutation callback.
  final ValueChanged<bool> onChanged;

  /// Descriptive visual node appearing alongside the control.
  final Widget? label;

  /// Alternative or overriding accessible text for screen readers.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    const minimumConstraints = BoxConstraints(
      minHeight: 44,
      minWidth: 44,
    );

    final switchComponent = Switch(
      value: value,
      onChanged: onChanged,
    );

    final Widget coreNode;

    if (label != null) {
      coreNode = GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            switchComponent,
            const SizedBox(width: 8),
            label!,
          ],
        ),
      );
    } else {
      coreNode = switchComponent;
    }

    return ConstrainedBox(
      constraints: minimumConstraints,
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: MergeSemantics(
          child: Semantics(
            label: semanticLabel,
            child: coreNode,
          ),
        ),
      ),
    );
  }
}
