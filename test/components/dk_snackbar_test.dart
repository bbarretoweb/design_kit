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

  group('DkSnackbar', () {
    testWidgets('show(variant: info) -> SnackBar appears in scaffold', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  DkSnackbar.show(context: context, message: 'Message');
                },
                child: const Text('Show'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump(); // Start animation

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Message'), findsOneWidget);
    });

    final defaultColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
    final defaultSemanticColors = DkSemanticColors.fallback(Brightness.light);

    test(
      'build(variant: success) -> backgroundColor == semanticColors.success',
      () {
        final snackbar = DkSnackbar.build(
          message: 'Message',
          colorScheme: defaultColorScheme,
          semanticColors: defaultSemanticColors,
          variant: DkSnackbarVariant.success,
        );
        expect(snackbar.backgroundColor, defaultSemanticColors.success);
      },
    );

    test('build(variant: error) -> backgroundColor == colorScheme.error', () {
      final snackbar = DkSnackbar.build(
        message: 'Message',
        colorScheme: defaultColorScheme,
        semanticColors: defaultSemanticColors,
        variant: DkSnackbarVariant.error,
      );
      expect(snackbar.backgroundColor, defaultColorScheme.error);
    });

    test(
      'build(variant: warning) -> backgroundColor == semanticColors.warning',
      () {
        final snackbar = DkSnackbar.build(
          message: 'Message',
          colorScheme: defaultColorScheme,
          semanticColors: defaultSemanticColors,
          variant: DkSnackbarVariant.warning,
        );
        expect(snackbar.backgroundColor, defaultSemanticColors.warning);
      },
    );

    test('action provided -> SnackBar.action is not null', () {
      final action = SnackBarAction(label: 'Undo', onPressed: () {});
      final snackbar = DkSnackbar.build(
        message: 'Message',
        colorScheme: defaultColorScheme,
        semanticColors: defaultSemanticColors,
        action: action,
      );
      expect(snackbar.action, isNotNull);
      expect(snackbar.action?.label, 'Undo');
    });
  });
}
