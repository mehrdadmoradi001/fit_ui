import 'package:fit_ui/fit_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ResponsiveValue
  group('ResponsiveValue', () {
    test('should return mobile value for all types when only mobile is provided',
            () {
          const responsiveValue = ResponsiveValue('mobile');
          expect(responsiveValue.resolve(DeviceScreenType.mobile), 'mobile');
          expect(responsiveValue.resolve(DeviceScreenType.tablet), 'mobile');
          expect(responsiveValue.resolve(DeviceScreenType.desktop), 'mobile');
        });

    test('should fall back to tablet value for desktop when desktop is null',
            () {
          const responsiveValue = ResponsiveValue('mobile', tablet: 'tablet');
          expect(responsiveValue.resolve(DeviceScreenType.mobile), 'mobile');
          expect(responsiveValue.resolve(DeviceScreenType.tablet), 'tablet');
          expect(responsiveValue.resolve(DeviceScreenType.desktop), 'tablet');
        });

    test(
        'should return the correct value for each screen type when all are provided',
            () {
          const responsiveValue =
          ResponsiveValue('mobile', tablet: 'tablet', desktop: 'desktop');
          expect(responsiveValue.resolve(DeviceScreenType.mobile), 'mobile');
          expect(responsiveValue.resolve(DeviceScreenType.tablet), 'tablet');
          expect(responsiveValue.resolve(DeviceScreenType.desktop), 'desktop');
        });
  });

  // ResponsiveConstraints Extension BoxConstraints
  group('ResponsiveConstraints Extension', () {
    test('should return mobile for widths up to mobile breakpoint', () {
      const constraints = BoxConstraints(maxWidth: 599);
      expect(constraints.screenType, DeviceScreenType.mobile);
    });

    test('should return tablet for widths between mobile and tablet breakpoints',
            () {
          const constraints = BoxConstraints(maxWidth: 800);
          expect(constraints.screenType, DeviceScreenType.tablet);
        });

    test('should return desktop for widths above tablet breakpoint', () {
      const constraints = BoxConstraints(maxWidth: 1000);
      expect(constraints.screenType, DeviceScreenType.desktop);
    });
  });

  //ResponsiveLayout
  group('ResponsiveLayout Widget', () {
    Future<void> testLayoutForSize(
        WidgetTester tester,
        Size size,
        String expectedText,
        ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;

      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsiveLayout(
            mobile: Text('Mobile'),
            tablet: Text('Tablet'),
            desktop: Text('Desktop'),
          ),
        ),
      );

      expect(find.text(expectedText), findsOneWidget);
    }

    testWidgets('should display mobile widget on mobile screen size',
            (WidgetTester tester) async {
          await testLayoutForSize(tester, const Size(400, 800), 'Mobile');
        });
    // Tablet Tests
    testWidgets('should display tablet widget on tablet screen size',
            (WidgetTester tester) async {
          await testLayoutForSize(tester, const Size(800, 900), 'Tablet');
        });
    // Desktop Tests
    testWidgets('should display desktop widget on desktop screen size',
            (WidgetTester tester) async {
          await testLayoutForSize(tester, const Size(1200, 900), 'Desktop');
        });

    // Fallback Tests
    testWidgets('should fall back to tablet when desktop is null',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(1200, 900);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: ResponsiveLayout(
                mobile: Text('Mobile'),
                tablet: Text('Tablet'),
              ),
            ),
          );

          expect(find.text('Tablet'), findsOneWidget);
        });
  });

  // BuildContext
  group('ResponsiveContext Extension', () {
    testWidgets('should return correct screen type based on MediaQuery',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(MaterialApp(
            home: Builder(
              builder: (context) => Text(context.screenType.name),
            ),
          ));
          expect(find.text('mobile'), findsOneWidget);

          tester.view.physicalSize = const Size(1200, 900);
          await tester.pumpWidget(MaterialApp(
            home: Builder(
              builder: (context) => Text(context.screenType.name),
            ),
          ));
          expect(find.text('desktop'), findsOneWidget);
        });
  });
}