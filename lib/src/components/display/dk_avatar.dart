import 'package:flutter/material.dart';

/// Prescribed dimension tokens for [DkAvatar].
enum DkAvatarSize {
  /// 32x32 logical pixels.
  sm,

  /// 40x40 logical pixels.
  md,

  /// 56x56 logical pixels.
  lg,
}

/// A circular profile element supporting image, icon, or initials fallback.
class DkAvatar extends StatelessWidget {
  /// Defines a standard semantic avatar.
  const DkAvatar({
    super.key,
    this.imageProvider,
    this.initials,
    this.icon,
    this.size = DkAvatarSize.md,
    this.semanticLabel,
  });

  /// The underlying image to visually represent. Always prioritized if present.
  final ImageProvider? imageProvider;

  /// The fallback initials if [imageProvider] is omitted. Usually max 2
  /// characters.
  final String? initials;

  /// The ultimate fallback icon if neither image nor initials are provided.
  final Widget? icon;

  /// Bound sizing token mapping directly to absolute logical pixels.
  final DkAvatarSize size;

  /// Explains the purpose or ownership of the avatar for screen readers.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dimension = switch (size) {
      DkAvatarSize.sm => 32.0,
      DkAvatarSize.md => 40.0,
      DkAvatarSize.lg => 56.0,
    };

    Widget? innerContent;
    if (imageProvider == null) {
      if (initials != null && initials!.isNotEmpty) {
        innerContent = Text(
          initials!,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        );
      } else {
        innerContent =
            icon ??
            Icon(
              Icons.person,
              color: theme.colorScheme.onPrimaryContainer,
              size: dimension * 0.6,
            );
      }
    }

    return Semantics(
      label: semanticLabel ?? initials ?? 'Profile image',
      image: true,
      child: SizedBox(
        width: dimension,
        height: dimension,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primaryContainer,
            image: imageProvider != null
                ? DecorationImage(
                    image: imageProvider!,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: innerContent != null ? Center(child: innerContent) : null,
        ),
      ),
    );
  }
}
