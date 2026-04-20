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

  group('DkBadge', () {
    testWidgets('count == 0 -> no badge widget in tree', (tester) async {
      await tester.pumpWidget(
        buildApp(const DkBadge(count: 0, child: Text('Child'))),
      );

      expect(find.text('Child'), findsOneWidget);
      expect(find.byType(Positioned), findsNothing);
    });

    testWidgets(
      'count == null -> Container with width and height == 8 present',
      (tester) async {
        await tester.pumpWidget(buildApp(const DkBadge(child: Text('Child'))));

        final containerFinder = find.descendant(
          of: find.bySemanticsLabel('Unread notification'),
          matching: find.byType(Container),
        );
        expect(containerFinder, findsOneWidget);
        final container = tester.widget<Container>(containerFinder);
        expect(container.constraints?.minWidth, 8);
        expect(container.constraints?.minHeight, 8);
      },
    );

    testWidgets('count == 5 -> Text("5") present', (tester) async {
      await tester.pumpWidget(
        buildApp(const DkBadge(count: 5, child: Text('Child'))),
      );
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('count == 150 -> Text("99+") present', (tester) async {
      await tester.pumpWidget(
        buildApp(const DkBadge(count: 150, child: Text('Child'))),
      );
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('Semantics node with label matching the count', (tester) async {
      await tester.pumpWidget(
        buildApp(const DkBadge(count: 3, child: Text('Child'))),
      );
      final semanticsFinder = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == '3',
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets(
      'Custom color applied -> badge Container decoration uses that color',
      (tester) async {
        const customColor = Colors.purple;
        await tester.pumpWidget(
          buildApp(
            const DkBadge(count: 5, color: customColor, child: Text('Child')),
          ),
        );

        final containerFinder = find
            .ancestor(
              of: find.text('5'),
              matching: find.byType(Container),
            )
            .first;
        final container = tester.widget<Container>(containerFinder);
        final decoration = container.decoration! as BoxDecoration;
        expect(decoration.color, customColor);
      },
    );
  });
}
