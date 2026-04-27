import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkBrandTheme implementations', () {
    testWidgets('AcmeBrandTheme().light() has brightness == Brightness.light', (
      tester,
    ) async {
      final theme = const AcmeBrandTheme().light();
      expect(theme.brightness, Brightness.light);
    });

    testWidgets(
      'AcmeBrandTheme().light() contains DkRadii with md == '
      'BorderRadius.circular(4)',
      (tester) async {
        final theme = const AcmeBrandTheme().light();
        final radii = theme.extension<DkRadii>();
        expect(radii?.md, const BorderRadius.all(Radius.circular(4)));
      },
    );

    testWidgets(
      'BiomeBrandTheme().light() contains DkRadii with md == '
      'BorderRadius.circular(16)',
      (tester) async {
        final theme = const BiomeBrandTheme().light();
        final radii = theme.extension<DkRadii>();
        expect(radii?.md, const BorderRadius.all(Radius.circular(16)));
      },
    );

    testWidgets(
      'BiomeBrandTheme().light() contains DkSpacing with md == 20.0',
      (tester) async {
        final theme = const BiomeBrandTheme().light();
        final spacing = theme.extension<DkSpacing>();
        expect(spacing?.md, 20.0);
      },
    );

    testWidgets('Both brands return ThemeData with useMaterial3 == true', (
      tester,
    ) async {
      final acme = const AcmeBrandTheme().light();
      final beta = const BiomeBrandTheme().light();
      expect(acme.useMaterial3, isTrue);
      expect(beta.useMaterial3, isTrue);
    });

    testWidgets(
      'Swap AcmeBrandTheme for BiomeBrandTheme -> DkButton renders '
      'without error',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: const AcmeBrandTheme().light(),
            home: Scaffold(
              body: DkButton.filled(
                label: const Text('Acme'),
                onPressed: () {},
              ),
            ),
          ),
        );
        expect(find.byType(DkButton), findsOneWidget);

        await tester.pumpWidget(
          MaterialApp(
            theme: const BiomeBrandTheme().light(),
            home: Scaffold(
              body: DkButton.filled(
                label: const Text('Beta'),
                onPressed: () {},
              ),
            ),
          ),
        );
        expect(find.byType(DkButton), findsOneWidget);
      },
    );
  });
}
