import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildApp(Widget child) {
    return MaterialApp(
      theme: DkTheme.build(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: DkTypography.buildTextTheme(
          fontFamily: 'Roboto',
          displayColor: Colors.black,
          bodyColor: Colors.black,
        ),
      ),
      home: Scaffold(body: child),
    );
  }

  group('DkChip', () {
    testWidgets('suggestion variant -> onPressed fires on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildApp(
          DkChip(
            label: const Text('Suggest'),
            onPressed: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(DkChip));
      expect(tapped, isTrue);
    });

    testWidgets('filter variant -> onPressed fires on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildApp(
          DkChip(
            label: const Text('Filter'),
            variant: DkChipVariant.filter,
            onPressed: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(DkChip));
      expect(tapped, isTrue);
    });

    testWidgets(
      'filter with selected: true -> inner FilterChip.selected is true',
      (tester) async {
        await tester.pumpWidget(
          buildApp(
            const DkChip(
              label: Text('Filter'),
              variant: DkChipVariant.filter,
              selected: true,
            ),
          ),
        );

        final filterChip = tester.widget<FilterChip>(find.byType(FilterChip));
        expect(filterChip.selected, isTrue);
      },
    );

    testWidgets('input variant -> delete icon present when onDeleted != null', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(
          DkChip(
            label: const Text('Input'),
            variant: DkChipVariant.input,
            onDeleted: () {},
          ),
        ),
      );

      final inputChip = tester.widget<InputChip>(find.byType(InputChip));
      expect(inputChip.onDeleted, isNotNull);
    });

    testWidgets('input variant -> onDeleted fires when delete icon tapped', (
      tester,
    ) async {
      var deleted = false;
      await tester.pumpWidget(
        buildApp(
          DkChip(
            label: const Text('Input'),
            variant: DkChipVariant.input,
            onDeleted: () => deleted = true,
          ),
        ),
      );

      await tester.tap(
        find.descendant(
          of: find.byType(InputChip),
          matching: find.byIcon(Icons.clear),
        ),
      );
      expect(deleted, isTrue);
    });

    testWidgets('All variants -> ConstrainedBox with minHeight >= 44 in tree', (
      tester,
    ) async {
      for (final variant in DkChipVariant.values) {
        await tester.pumpWidget(
          buildApp(
            DkChip(
              label: const Text('Chip'),
              variant: variant,
            ),
          ),
        );

        final constrainedBoxFinder = find
            .descendant(
              of: find.byType(DkChip),
              matching: find.byType(ConstrainedBox),
            )
            .first;

        final box = tester.widget<ConstrainedBox>(constrainedBoxFinder);
        expect(box.constraints.minHeight, greaterThanOrEqualTo(44.0));
      }
    });
  });
}
