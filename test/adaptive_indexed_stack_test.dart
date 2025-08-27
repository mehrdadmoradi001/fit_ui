import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fit_ui/fit_ui.dart';

void main() {
  group('AdaptiveIndexedStack', () {
    testWidgets('should show correct index based on screen size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: SizedBox(
              width: 800, // Tablet width
              child: AdaptiveIndexedStack(
                mobile: Text('Mobile'),
                tablet: Text('Tablet'),
                desktop: Text('Desktop'),
              ),
            ),
          ),
        ),
      );

      // Check that the Tablet widget is the one being displayed.
      final indexedStack = tester.widget<IndexedStack>(find.byType(IndexedStack));

      // Assert that the correct index (1 for tablet) is set.
      expect(indexedStack.index, 1);// 0: mobile, 1: tablet, 2: desktop
    });
  });
}