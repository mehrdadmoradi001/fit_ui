// FILE: lib/src/extensions/box_constraints_ext.dart
import 'package:flutter/widgets.dart';
import '../breakpoints.dart';
import '../device_screen_type.dart';
import '../responsive_value.dart';

/// {@template responsive_ui.box_constraints_ext}
/// Extension on [BoxConstraints] for making **local, layout-dependent**
/// responsive decisions.
///
/// This is the recommended way to handle responsive values for widgets that
/// need to adapt to their own available space, not the entire screen.
/// This ensures components are truly modular and reusable.
///
/// See also:
/// * [ResponsiveValue], the class that holds the values to resolve.
/// {@endtemplate}
extension ResponsiveConstraints on BoxConstraints {
  /// Determines the [DeviceScreenType] based on the `maxWidth` of these
  /// constraints and the default [AppBreakpoints].
  DeviceScreenType get screenType {
    return const DefaultBreakpointProvider().getScreenType(maxWidth);
  }

  /// Determines the [DeviceScreenType] using a custom [BreakpointProvider].
  DeviceScreenType screenTypeUsing(BreakpointProvider provider) {
    return provider.getScreenType(maxWidth);
  }

  /// Resolves a [ResponsiveValue<T>] based on these local constraints
  /// and the default [AppBreakpoints].
  ///
  /// Use this inside a [LayoutBuilder] for component-level responsiveness.
  ///
  /// ### Example
  /// ```dart
  /// LayoutBuilder(
  ///   builder: (context, constraints) {
  ///     final columns = constraints.value(const ResponsiveValue(2, tablet: 4));
  ///     return GridView.builder(crossAxisCount: columns, ...);
  ///   },
  /// )
  /// ```
  T value<T>(ResponsiveValue<T> responsiveValue) {
    return responsiveValue.resolve(screenType);
  }

  /// Resolves a [ResponsiveValue<T>] using a custom [BreakpointProvider].
  T valueWith<T>(
    ResponsiveValue<T> responsiveValue,
    BreakpointProvider provider,
  ) {
    return responsiveValue.resolve(screenTypeUsing(provider));
  }
}
