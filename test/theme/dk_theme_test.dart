import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkTheme and Extensions Tests', () {
    test(
      'DkTheme correctly injects fallbacks extensions when not provided',
      () {
        final theme = DkTheme.build(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: DkTypography.buildTextTheme(
            fontFamily: 'Roboto',
            displayColor: Colors.black,
            bodyColor: Colors.black87,
          ),
        );

        final semantics = theme.extension<DkSemanticColors>();
        expect(semantics, isNotNull);
        expect(semantics?.success, const Color(0xFF2E7D32)); // Light fallback

        final spacing = theme.extension<DkSpacing>();
        expect(spacing, isNotNull);
        expect(spacing?.md, 16.0);

        final radii = theme.extension<DkRadii>();
        expect(radii, isNotNull);
        expect(radii?.md, const BorderRadius.all(Radius.circular(8)));
      },
    );

    test('DkSemanticColors lerps correctly between two states', () {
      const lightSemantics = DkSemanticColors(
        success: Colors.green,
        onSuccess: Colors.white,
        warning: Colors.orange,
        onWarning: Colors.white,
        info: Colors.blue,
        onInfo: Colors.white,
      );

      const darkSemantics = DkSemanticColors(
        success: Colors.greenAccent,
        onSuccess: Colors.black,
        warning: Colors.orangeAccent,
        onWarning: Colors.black,
        info: Colors.lightBlue,
        onInfo: Colors.black,
      );

      final lerpedMiddle = lightSemantics.lerp(darkSemantics, 0.5);

      expect(
        lerpedMiddle.success,
        Color.lerp(Colors.green, Colors.greenAccent, 0.5),
      );

      final lerpedEnd = lightSemantics.lerp(darkSemantics, 1);
      expect(
        lerpedEnd.success.toARGB32(),
        Colors.greenAccent.toARGB32(),
      );
    });

    test('DkSpacing lerps correctly between two states', () {
      const smallSpacing = DkSpacing(
        xs: 2,
        sm: 4,
        md: 8,
        lg: 12,
        xl: 16,
        xxl: 24,
      );
      const standardSpacing = DkSpacing();

      final lerpedMiddle = smallSpacing.lerp(standardSpacing, 0.5);

      expect(lerpedMiddle.xs, 3.0); // Between 2.0 and 4.0
      expect(lerpedMiddle.md, 12.0); // Between 8.0 and 16.0
    });
  });
}
