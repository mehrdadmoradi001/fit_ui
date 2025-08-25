import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fit_ui/fit_ui.dart';

void main() {
  group('ResponsiveLayoutBuilder', () {
    testWidgets('should provide correct screen type to builder', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 800, // Tablet width
              child: ResponsiveLayoutBuilder(
                builder: (screenType, constraints) {
                  return Text('Screen type: $screenType');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Screen type: DeviceScreenType.tablet'), findsOneWidget);
    });
  });
}