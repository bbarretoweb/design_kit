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

  group('DkSwitch', () {
    testWidgets('value: false -> tapping fires onChanged(true)', (
      tester,
    ) async {
      bool? latestValue;
      await tester.pumpWidget(
        buildApp(
          DkSwitch(
            value: false,
            onChanged: (val) => latestValue = val,
          ),
        ),
      );

      await tester.tap(find.byType(DkSwitch));
      expect(latestValue, isTrue);
    });

    testWidgets('value: true -> tapping fires onChanged(false)', (
      tester,
    ) async {
      bool? latestValue;
      await tester.pumpWidget(
        buildApp(
          DkSwitch(
            value: true,
            onChanged: (val) => latestValue = val,
          ),
        ),
      );

      await tester.tap(find.byType(DkSwitch));
      expect(latestValue, isFalse);
    });

    testWidgets("label: 'Enable' -> Text('Enable') present", (tester) async {
      await tester.pumpWidget(
        buildApp(
          DkSwitch(
            value: false,
            onChanged: (val) {},
            label: const Text('Enable'),
          ),
        ),
      );
      expect(find.text('Enable'), findsOneWidget);
    });

    testWidgets('Tapping label Text fires onChanged', (tester) async {
      bool? latestValue;
      await tester.pumpWidget(
        buildApp(
          DkSwitch(
            value: false,
            onChanged: (val) => latestValue = val,
            label: const Text('Enable'),
          ),
        ),
      );

      await tester.tap(find.text('Enable'));
      expect(latestValue, isTrue);
    });

    testWidgets("semanticLabel: 'Notifications' -> present in Semantics node", (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(
          DkSwitch(
            value: false,
            onChanged: (val) {},
            semanticLabel: 'Notifications',
          ),
        ),
      );

      expect(find.bySemanticsLabel('Notifications'), findsOneWidget);
    });

    testWidgets('ConstrainedBox with minHeight >= 44 in tree', (tester) async {
      await tester.pumpWidget(
        buildApp(
          DkSwitch(
            value: false,
            onChanged: (val) {},
          ),
        ),
      );

      final constrainedBoxFinder = find
          .descendant(
            of: find.byType(DkSwitch),
            matching: find.byType(ConstrainedBox),
          )
          .first;

      final box = tester.widget<ConstrainedBox>(constrainedBoxFinder);
      expect(box.constraints.minHeight, greaterThanOrEqualTo(44.0));
    });
  });
}
