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

  group('DkDivider', () {
    testWidgets(
      'axis: horizontal -> exactly one Divider widget in tree when no label', (
      tester,
    ) async {
      await tester.pumpWidget(buildApp(const DkDivider()));
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets(
      'axis: vertical -> exactly one VerticalDivider widget in tree when '
      'no label',
      (tester) async {
        await tester.pumpWidget(buildApp(const DkDivider(axis: Axis.vertical)));
        expect(find.byType(VerticalDivider), findsOneWidget);
      },
    );

    testWidgets('label: provided -> exactly two widgets in tree',
        (tester) async {
      await tester.pumpWidget(buildApp(const DkDivider(label: Text('OR'))));
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets("label: 'OR' provided -> Text('OR') present", (tester) async {
      await tester.pumpWidget(buildApp(const DkDivider(label: Text('OR'))));
      expect(find.text('OR'), findsOneWidget);
    });

    testWidgets('No label -> zero Text widgets in tree', (tester) async {
      await tester.pumpWidget(buildApp(const DkDivider()));
      expect(find.byType(Text), findsNothing);
    });
  });
}
