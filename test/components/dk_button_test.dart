import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkButton Component Tests', () {
    testWidgets('renders all 3 button variants perfectly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: <Widget>[
                DkButton.filled(
                  label: const Text('Filled'),
                  onPressed: () {},
                ),
                DkButton.text(
                  label: const Text('Text'),
                  onPressed: () {},
                ),
                DkButton.outlined(
                  label: const Text('Outlined'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);

      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
    });

    testWidgets('onPressed callback is triggered correctly', (tester) async {
      var wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DkButton.filled(
              label: const Text('Tap me'),
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pumpAndSettle();

      expect(wasPressed, isTrue);
    });

    testWidgets(
      'shows CircularProgressIndicator and disables onPressed '
      'on isLoading == true',
      (tester) async {
        var wasPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DkButton.filled(
                label: const Text('Loading Test'),
                isLoading: true,
                onPressed: () {
                  wasPressed = true;
                },
              ),
            ),
          ),
        );

        // Label should be hidden, circular progress should appear
        expect(find.text('Loading Test'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Tapping should not trigger onPressed
        await tester.tap(find.byType(DkButton));
        await tester.pump();

        expect(wasPressed, isFalse);

        // Ensure button semantic is strictly deactivated
        final innerButton = tester.widget<FilledButton>(
          find.byType(FilledButton),
        );
        expect(innerButton.onPressed, isNull);
      },
    );
  });
}
