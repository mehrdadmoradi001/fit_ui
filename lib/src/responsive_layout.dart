// FILE: lib/src/responsive_layout.dart
import 'package:flutter/widgets.dart';
import 'breakpoints.dart';
import 'device_screen_type.dart';
import 'extensions/box_constraints_ext.dart';

/// {@template responsive_ui.responsive_layout}
/// A widget that selects a layout based on the available screen width.
///
/// This widget is the primary tool for making structural changes in your UI,
/// such as switching between a single-column layout on mobile and a
/// two-column layout on desktop.
///
/// It uses a [LayoutBuilder] internally, making it aware of its local
/// constraints, not the entire screen. This ensures true component
/// encapsulation and reusability.
///
/// For values that change responsively (like padding, font size, number of
/// columns), prefer using the [ResponsiveValue] with a [LayoutBuilder] and
/// the `BoxConstraints.value()` extension instead of building three
/// different widgets.
/// {@endtemplate}
class ResponsiveLayout extends StatelessWidget {
  /// The layout to display for mobile. This is required.
  final Widget mobile;

  /// The layout to display for tablet.
  /// If null, [mobile] is used as a fallback.
  final Widget? tablet;

  /// The layout to display for desktop.
  /// If null, [tablet] or [mobile] is used as a fallback.
  final Widget? desktop;

  /// Optional custom breakpoint provider
  final BreakpointProvider? breakpointProvider;

  /// Creates a [ResponsiveLayout] using the default [AppBreakpoints].
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.breakpointProvider,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final DeviceScreenType screenType = breakpointProvider != null
            ? constraints.screenTypeUsing(breakpointProvider!)
            : constraints.screenType;

        switch (screenType) {
          case DeviceScreenType.desktop:
            return desktop ?? tablet ?? mobile;
          case DeviceScreenType.tablet:
            return tablet ?? mobile;
          case DeviceScreenType.mobile:
            return mobile;
        }
      },
    );
  }
}