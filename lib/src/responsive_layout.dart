import 'package:flutter/widgets.dart';
import 'device_screen_type.dart';
import 'extensions/box_constraints_ext.dart';

/// A widget that selects a layout based on the available screen width.
///
/// This widget is the primary tool for making structural changes in your UI,
/// such as switching between a single-column layout on mobile and a
/// two-column layout on desktop.
///
/// It uses a internally, making it aware of its local constraints,
/// not the entire screen.
class ResponsiveLayout extends StatelessWidget {
  /// The layout to display for. This is required.
  final Widget mobile;

  /// The layout to display for.
  /// If null, [mobile] is used as a fallback.
  final Widget? tablet;

  /// The layout to display for.
  /// If null, [tablet] or [mobile] is used as a fallback.
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = constraints.screenType;
        switch (screenType) {
          case DeviceScreenType.desktop:
            return desktop?? tablet?? mobile;
          case DeviceScreenType.tablet:
            return tablet?? mobile;
          case DeviceScreenType.mobile:
            return mobile;
        }
      },
    );
  }
}