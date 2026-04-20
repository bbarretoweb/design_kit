import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DkGrid', () {
    testWidgets('renders as single column on small screens', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DkGrid(
              children: [
                Container(height: 50, color: Colors.red),
                Container(height: 50, color: Colors.blue),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Wrap), findsNothing);

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });

    testWidgets('renders as wrap on wider screens', (tester) async {
      tester.view.physicalSize = const Size(800, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DkGrid(
              children: [
                Container(height: 50, color: Colors.red),
                Container(height: 50, color: Colors.blue),
                Container(height: 50, color: Colors.green),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });
  });
}
