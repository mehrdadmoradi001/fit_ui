import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fit_ui/fit_ui.dart';

void main() {
  group('ResponsiveSlots', () {
    testWidgets('should use Row layout for desktop screens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 1200, // Desktop width
              child: ResponsiveSlots(
                header: (screenType) => const Text('Header'),
                body: (screenType) => const Text('Body'),
                side: (screenType) => const Text('Side'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should use Column layout for mobile/tablet screens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 800, // Tablet width
              child: ResponsiveSlots(
                header: (screenType) => const Text('Header'),
                body: (screenType) => const Text('Body'),
                side: (screenType) => const Text('Side'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('should apply custom spacing when provided', (tester) async {
      // 1. Test custom desktop spacing
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 1200, // Desktop width
              child: ResponsiveSlots(
                desktopSideSpacing: 24.0, // Custom value
                header: (screenType) => const Text('Header'),
                body: (screenType) => const Text('Body'),
                side: (screenType) => const Text('Side'),
              ),
            ),
          ),
        ),
      );

      final desktopSpacer = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(desktopSpacer.width, 24.0);

      // 2. Test custom tablet spacing
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 800, // Tablet width
              child: ResponsiveSlots(
                tabletSideSpacing: 18.0, // Custom value
                header: (screenType) => const Text('Header'),
                body: (screenType) => const Text('Body'),
                side: (screenType) => const Text('Side'),
              ),
            ),
          ),
        ),
      );

      final tabletSpacer = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(tabletSpacer.height, 18.0);
    });
  });
}