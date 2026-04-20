import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkTag', () {
    testWidgets('renders label correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTag(label: 'Flutter'),
          ),
        ),
      );

      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('applies semantics correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTag(label: 'Dart'),
          ),
        ),
      );

      final semanticsWidget = tester.widget<Semantics>(
        find
            .descendant(
              of: find.byType(DkTag),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semanticsWidget.properties.label, 'Dart');
      expect(semanticsWidget.properties.readOnly, isTrue);
    });

    testWidgets('respects custom colors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTag(
              label: 'Custom',
              backgroundColor: Colors.red,
              textColor: Colors.blue,
            ),
          ),
        ),
      );

      final decoratedBox = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(DkTag),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.color, Colors.red);

      final text = tester.widget<Text>(find.text('Custom'));
      expect(text.style?.color, Colors.blue);
    });
  });
}
