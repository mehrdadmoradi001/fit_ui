import 'package:flutter_test/flutter_test.dart';
import 'package:fit_ui/fit_ui.dart';

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

    test('should fallback to tablet then mobile when desktop value is null',
        () {
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
}
