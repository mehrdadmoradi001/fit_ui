import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fit_ui/fit_ui.dart';

void main() {
  group('ResponsiveLayout', () {
    testWidgets('should show mobile widget on mobile screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: SizedBox(
              width: 500, // Mobile width
              child: ResponsiveLayout(
                mobile: Text('Mobile'),
                tablet: Text('Tablet'),
                desktop: Text('Desktop'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.text('Tablet'), findsNothing);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('should show tablet widget on tablet screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: SizedBox(
              width: 800, // Tablet width
              child: ResponsiveLayout(
                mobile: Text('Mobile'),
                tablet: Text('Tablet'),
                desktop: Text('Desktop'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Tablet'), findsOneWidget);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('should show desktop widget on desktop screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: SizedBox(
              width: 1200, // Desktop width
              child: ResponsiveLayout(
                mobile: Text('Mobile'),
                tablet: Text('Tablet'),
                desktop: Text('Desktop'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Tablet'), findsNothing);
      expect(find.text('Desktop'), findsOneWidget);
    });

    testWidgets('should fallback to mobile when tablet is missing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: SizedBox(
              width: 800, // Tablet width
              child: ResponsiveLayout(
                mobile: Text('Mobile'),
                desktop: Text('Desktop'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
    });
  });
}