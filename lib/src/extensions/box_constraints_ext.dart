import 'package:flutter/widgets.dart';
import '../breakpoints.dart';
import '../device_screen_type.dart';
import '../responsive_value.dart';

/// Extension on for making **local, layout-dependent** responsive decisions.
///
/// This is the recommended way to handle responsive values for widgets that need to
/// adapt to their own available space, not the entire screen. This ensures
/// components are truly modular and reusable.
extension ResponsiveConstraints on BoxConstraints {
  /// Determines the based on the `maxWidth` of the constraints.
  DeviceScreenType get screenType {
    if (maxWidth > AppBreakpoints.tablet) return DeviceScreenType.desktop;
    if (maxWidth > AppBreakpoints.mobile) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }

  /// Resolves a based on the local constraints.
  ///
  /// Use this inside a for component-level responsiveness.
  ///
  /// Example:
  /// ```dart
  /// LayoutBuilder(
  ///   builder: (context, constraints) {
  ///     final columns = constraints.value(ResponsiveValue(2, tablet: 4));
  ///     return GridView.builder(crossAxisCount: columns,...);
  ///   }
  /// )
  /// ```
  T value<T>(ResponsiveValue<T> responsiveValue) {
    return responsiveValue.resolve(screenType);
  }
}