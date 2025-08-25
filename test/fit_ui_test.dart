// FILE: test/fit_ui_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fit_ui/fit_ui.dart';

// Define custom breakpoint provider at the top level
class CustomBreakpoints implements BreakpointProvider {
  @override
  DeviceScreenType getScreenType(double width) {
    if (width > 2000) return DeviceScreenType.desktop;
    if (width > 1000) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }
}

void main() {
  group('ResponsiveValue', () {
    test('should resolve mobile value correctly', () {
      const responsiveValue = ResponsiveValue<int>(10, tablet: 20, desktop: 30);
      expect(responsiveValue.resolve(DeviceScreenType.mobile), 10);
    });

    test('should resolve tablet value correctly', () {
      const responsiveValue = ResponsiveValue<int>(10, tablet: 20, desktop: 30);
      expect(responsiveValue.resolve(DeviceScreenType.tablet), 20);
    });

    test('should resolve desktop value correctly', () {
      const responsiveValue = ResponsiveValue<int>(10, tablet: 20, desktop: 30);
      expect(responsiveValue.resolve(DeviceScreenType.desktop), 30);
    });

    test('should fallback to mobile when tablet value is null', () {
      const responsiveValue = ResponsiveValue<int>(10, desktop: 30);
      expect(responsiveValue.resolve(DeviceScreenType.tablet), 10);
    });

    test('should fallback to tablet then mobile when desktop value is null', () {
      const responsiveValue = ResponsiveValue<int>(10, tablet: 20);
      expect(responsiveValue.resolve(DeviceScreenType.desktop), 20);
    });

    test('map should transform values correctly', () {
      const responsiveValue = ResponsiveValue<int>(10, tablet: 20, desktop: 30);
      final mapped = responsiveValue.map((value) => value * 2);
      expect(mapped.resolve(DeviceScreenType.mobile), 20);
      expect(mapped.resolve(DeviceScreenType.tablet), 40);
      expect(mapped.resolve(DeviceScreenType.desktop), 60);
    });
  });

  group('BoxConstraints extensions', () {
    test('should return correct screen type for mobile', () {
      const constraints = BoxConstraints(maxWidth: 500);
      expect(constraints.screenType, DeviceScreenType.mobile);
    });

    test('should return correct screen type for tablet', () {
      const constraints = BoxConstraints(maxWidth: 800);
      expect(constraints.screenType, DeviceScreenType.tablet);
    });

    test('should return correct screen type for desktop', () {
      const constraints = BoxConstraints(maxWidth: 1200);
      expect(constraints.screenType, DeviceScreenType.desktop);
    });

    test('should resolve responsive value correctly', () {
      const constraints = BoxConstraints(maxWidth: 800);
      const responsiveValue = ResponsiveValue<int>(1, tablet: 2, desktop: 3);
      expect(constraints.value(responsiveValue), 2);
    });
  });

  group('ResponsiveLayout', () {
    testWidgets('should show mobile widget on mobile screen', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: SizedBox(
            width: 500, // Mobile width
            child: ResponsiveLayout(
              mobile: Text('Mobile'),
              tablet: Text('Tablet'),
              desktop: Text('Desktop'),
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
        const Center(
          child: SizedBox(
            width: 800, // Tablet width
            child: ResponsiveLayout(
              mobile: Text('Mobile'),
              tablet: Text('Tablet'),
              desktop: Text('Desktop'),
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
        const Center(
          child: SizedBox(
            width: 1200, // Desktop width
            child: ResponsiveLayout(
              mobile: Text('Mobile'),
              tablet: Text('Tablet'),
              desktop: Text('Desktop'),
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
        const Center(
          child: SizedBox(
            width: 800, // Tablet width
            child: ResponsiveLayout(
              mobile: Text('Mobile'),
              desktop: Text('Desktop'),
            ),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
    });
  });

  group('ResponsiveLayoutBuilder', () {
    testWidgets('should provide correct screen type to builder', (tester) async {
      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: 800, // Tablet width
            child: ResponsiveLayoutBuilder(
              builder: (screenType, constraints) {
                return Text('Screen type: $screenType');
              },
            ),
          ),
        ),
      );

      expect(find.text('Screen type: DeviceScreenType.tablet'), findsOneWidget);
    });
  });

  group('AdaptiveIndexedStack', () {
    testWidgets('should show correct index based on screen size', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: SizedBox(
            width: 800, // Tablet width
            child: AdaptiveIndexedStack(
              mobile: Text('Mobile'),
              tablet: Text('Tablet'),
              desktop: Text('Desktop'),
            ),
          ),
        ),
      );

      expect(find.text('Tablet'), findsOneWidget);
    });
  });

  group('ResponsiveSlots', () {
    testWidgets('should use Row layout for desktop screens', (tester) async {
      await tester.pumpWidget(
        MaterialApp( // Wrap with MaterialApp for directionality
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

      // Should use Row layout for desktop
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should use Column layout for mobile/tablet screens', (tester) async {
      await tester.pumpWidget(
        MaterialApp( // Wrap with MaterialApp
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

      // Should use Column layout for tablet
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

      // Find the SizedBox in the Row and check its width
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

      // Find the SizedBox in the Column and check its height
      final tabletSpacer = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(tabletSpacer.height, 18.0);
    });
  });

  group('Custom Breakpoints', () {
    test('should use custom breakpoint provider', () {
      const constraints = BoxConstraints(maxWidth: 1500);
      final screenType = constraints.screenTypeUsing(CustomBreakpoints());

      expect(screenType, DeviceScreenType.tablet);
    });
  });
}
