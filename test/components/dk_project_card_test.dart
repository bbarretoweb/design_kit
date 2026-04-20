import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkProjectCard', () {
    testWidgets('renders all content slots', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkProjectCard(
              title: 'My Game',
              subtitle: 'A flutter game',
              description: 'Created with Flame engine.',
              tags: [
                DkTag(label: 'Flame'),
                DkTag(label: 'Dart'),
              ],
              callToAction: DkButton.outlined(label: Text('Play')),
            ),
          ),
        ),
      );

      expect(find.text('My Game'), findsOneWidget);
      expect(find.text('A flutter game'), findsOneWidget);
      expect(find.text('Created with Flame engine.'), findsOneWidget);
      expect(find.byType(DkTag), findsNWidgets(2));
      expect(find.byType(DkButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DkProjectCard(
              title: 'Interactive Card',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DkProjectCard));
      expect(tapped, isTrue);
    });

    testWidgets('renders hero image with semantics', (tester) async {
      final testImage = MemoryImage(
        Uri.parse(
          'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7',
        ).data!.contentAsBytes(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DkProjectCard(
              title: 'Image Card',
              heroImage: testImage,
              imageSemanticLabel: 'A cool screenshot',
            ),
          ),
        ),
      );

      final semanticsWidget = tester
          .widgetList<Semantics>(
            find.descendant(
              of: find.byType(DkProjectCard),
              matching: find.byType(Semantics),
            ),
          )
          .firstWhere((s) => s.properties.image == true);
      expect(semanticsWidget.properties.label, 'A cool screenshot');
      expect(semanticsWidget.properties.image, isTrue);
    });
  });
}
