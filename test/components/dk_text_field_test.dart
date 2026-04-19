import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkTextField Component Tests', () {
    testWidgets('renders accurately and displays hintText', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTextField(
              hintText: 'Enter your email',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('displays error text dynamically', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTextField(
              hintText: 'Enter your email',
              errorText: 'Invalid email address',
            ),
          ),
        ),
      );

      expect(find.text('Invalid email address'), findsOneWidget);
    });

    testWidgets('handles secure text entry properly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DkTextField(
              hintText: 'Enter password',
              obscureText: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });
  });
}
