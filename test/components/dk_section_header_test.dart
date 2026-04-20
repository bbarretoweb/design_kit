import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkSectionHeader', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkSectionHeader(
              title: 'Projects',
              subtitle: 'My Work',
            ),
          ),
        ),
      );

      expect(find.text('Projects'), findsOneWidget);
      expect(find.text('My Work'), findsOneWidget);
    });

    testWidgets('renders trailing action when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkSectionHeader(
              title: 'Projects',
              trailingAction: DkButton.text(label: Text('View All')),
            ),
          ),
        ),
      );

      expect(find.byType(DkButton), findsOneWidget);
      expect(find.text('View All'), findsOneWidget);
    });

    testWidgets('can hide divider', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkSectionHeader(
              title: 'Projects',
              showDivider: false,
            ),
          ),
        ),
      );

      expect(find.byType(DkDivider), findsNothing);
    });

    testWidgets('semantics mark title as header', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkSectionHeader(title: 'Skills'),
          ),
        ),
      );

      final semanticsWidget = tester.widget<Semantics>(
        find
            .descendant(
              of: find.byType(DkSectionHeader),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semanticsWidget.properties.header, isTrue);
    });
  });
}
