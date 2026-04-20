import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildApp(Widget child, {DkRadii? customRadii}) {
    return MaterialApp(
      theme: DkTheme.build(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: DkTypography.buildTextTheme(
          fontFamily: 'Roboto',
          displayColor: Colors.black,
          bodyColor: Colors.black,
        ),
        radii: customRadii,
      ),
      home: Scaffold(body: child),
    );
  }

  group('DkTextField', () {
    testWidgets("errorText: 'Required' -> Text('Required') visible", (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(
          const DkTextField(
            hintText: 'Enter value',
            errorText: 'Required',
          ),
        ),
      );

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('obscureText: true -> EditableText.obscureText == true', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(
          const DkTextField(
            hintText: 'Password',
            obscureText: true,
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets("Typing 'hello' -> onChanged called with 'hello'", (
      tester,
    ) async {
      String? typedText;
      await tester.pumpWidget(
        buildApp(
          DkTextField(
            hintText: 'Enter text',
            onChanged: (val) => typedText = val,
          ),
        ),
      );

      await tester.enterText(find.byType(DkTextField), 'hello');
      expect(typedText, 'hello');
    });

    testWidgets(
      'DkRadii injected via theme -> OutlineInputBorder uses that radius',
      (tester) async {
        const radii = DkRadii(md: BorderRadius.all(Radius.circular(20)));
        await tester.pumpWidget(
          buildApp(
            const DkTextField(
              hintText: 'Enter value',
            ),
            customRadii: radii,
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        final decoration = textField.decoration!;
        final border = decoration.border! as OutlineInputBorder;
        expect(
          border.borderRadius,
          const BorderRadius.all(Radius.circular(20)),
        );
      },
    );
  });
}
