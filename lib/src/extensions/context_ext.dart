import 'package:flutter/widgets.dart';
import '../breakpoints.dart';
import '../device_screen_type.dart';
import '../responsive_value.dart';

/// Extension on for making **global, non-layout-dependent** responsive decisions.
///
/// This uses [MediaQuery] and should be used with caution. It's suitable for values
/// that don't affect the widget's size or layout structure, such as colors,
/// text styles, or animation values.
///
/// **Warning:** Avoid using this for sizes, padding, or margins inside reusable
/// components, as it can break encapsulation. For those cases, use a
/// with the `ResponsiveConstraints` extension instead.
extension ResponsiveContext on BuildContext {
  /// Determines the based on the `width` of the entire screen.
  DeviceScreenType get screenType {
    final width = MediaQuery.sizeOf(this).width;
    if (width > AppBreakpoints.tablet) return DeviceScreenType.desktop;
    if (width > AppBreakpoints.mobile) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }

  /// Resolves a based on the global screen size.
  ///
  /// Best for non-structural values like colors or font weights.
  ///
  /// Example:
  /// ```dart
  /// Card(
  ///   color: context.value(ResponsiveValue(Colors.blue, desktop: Colors.grey)),
  ///  ...
  /// )
  /// ```
  T value<T>(ResponsiveValue<T> responsiveValue) {
    return responsiveValue.resolve(screenType);
  }
}