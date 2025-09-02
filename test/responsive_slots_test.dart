import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fit_ui/fit_ui.dart';

void main() {
  group('ResponsiveSlots', () {
    Widget buildTestableWidget(
        {double? desktopSpacing, double? tabletSpacing}) {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveSlots(
            desktopSideSpacing: desktopSpacing ?? 16.0,
            tabletSideSpacing: tabletSpacing ?? 12.0,
            header: (screenType) => const Text('Header'),
            body: (screenType) => const Text('Body'),
            side: (screenType) => const Text('Side'),
          ),
        ),
      );
    }

    // desktop
    testWidgets('should use Row layout for desktop screens', (tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(1200, 900);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should use Column layout for tablet screens', (tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(800, 1200);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final columnFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.any((child) => child is Expanded),
      );
      expect(columnFinder, findsOneWidget);
      expect(find.byType(Row), findsNothing);
    });

    testWidgets('should apply custom spacing when provided', (tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(1200, 900);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableWidget(desktopSpacing: 24.0));
      await tester.pumpAndSettle();

      final row = tester.widget<Row>(find.byType(Row));
      final spacer = row.children.firstWhere((w) => w is SizedBox) as SizedBox;
      expect(spacer.width, 24.0);

      // tablet
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableWidget(tabletSpacing: 18.0));
      await tester.pumpAndSettle();

      final column = tester.widget<Column>(find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.any((child) => child is Expanded),
      ));
      final tabletSpacer =
          column.children.firstWhere((w) => w is SizedBox) as SizedBox;
      expect(tabletSpacer.height, 18.0);
    });
  });
}
