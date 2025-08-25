import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:fit_ui/fit_ui.dart';

// A custom breakpoint provider just for testing this extension.
class CustomBreakpoints implements BreakpointProvider {
  @override
  DeviceScreenType getScreenType(double width) {
    if (width > 2000) return DeviceScreenType.desktop;
    if (width > 1000) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }
}

void main() {
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

    test('should use custom breakpoint provider', () {
      const constraints = BoxConstraints(maxWidth: 1500);
      final screenType = constraints.screenTypeUsing(CustomBreakpoints());
      expect(screenType, DeviceScreenType.tablet);
    });
  });
}