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

  group('DkAvatar', () {
    testWidgets("initials: 'AB' -> Text('AB') present", (tester) async {
      await tester.pumpWidget(buildApp(const DkAvatar(initials: 'AB')));
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('icon provided, no initials -> icon widget present', (
      tester,
    ) async {
      await tester.pumpWidget(buildApp(const DkAvatar(icon: Icon(Icons.star))));
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('No initials, no icon -> Icons.person rendered', (
      tester,
    ) async {
      await tester.pumpWidget(buildApp(const DkAvatar()));
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('DkAvatarSize.sm -> rendered SizedBox is 32x32', (
      tester,
    ) async {
      await tester.pumpWidget(buildApp(const DkAvatar(size: DkAvatarSize.sm)));
      final sizedBoxFinder = find
          .descendant(
            of: find.byType(DkAvatar),
            matching: find.byType(SizedBox),
          )
          .first;
      final box = tester.widget<SizedBox>(sizedBoxFinder);
      expect(box.width, 32.0);
      expect(box.height, 32.0);
    });

    testWidgets('DkAvatarSize.lg -> rendered SizedBox is 56x56', (
      tester,
    ) async {
      await tester.pumpWidget(buildApp(const DkAvatar(size: DkAvatarSize.lg)));
      final sizedBoxFinder = find
          .descendant(
            of: find.byType(DkAvatar),
            matching: find.byType(SizedBox),
          )
          .first;
      final box = tester.widget<SizedBox>(sizedBoxFinder);
      expect(box.width, 56.0);
      expect(box.height, 56.0);
    });

    testWidgets("semanticLabel: 'Profile photo' -> present in Semantics node", (
      tester,
    ) async {
      await tester.pumpWidget(
        buildApp(const DkAvatar(semanticLabel: 'Profile photo')),
      );
      final semanticsFinder = find.bySemanticsLabel('Profile photo');
      expect(semanticsFinder, findsOneWidget);
    });
  });
}
