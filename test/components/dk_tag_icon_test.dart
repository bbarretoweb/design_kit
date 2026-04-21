import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkTag Icon Support', () {
    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTag(
              label: 'Flutter',
              icon: Icon(Icons.bolt, key: Key('tag-icon')),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('tag-icon')), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('renders without icon when not provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTag(label: 'Dart'),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
      expect(find.text('Dart'), findsOneWidget);
    });
  });
}
