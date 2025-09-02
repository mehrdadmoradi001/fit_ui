// FILE: lib/src/adaptive_indexed_stack.dart
import 'package:flutter/widgets.dart';
import 'breakpoints.dart';
import 'device_screen_type.dart';

/// {@template responsive_ui.adaptive_indexed_stack}
/// A widget that maintains the state of multiple screen variants and switches
/// between them based on the current screen type.
///
/// This is useful for preserving state across screen size changes, such as
/// form data or scroll position.
/// {@endtemplate}
class AdaptiveIndexedStack extends StatelessWidget {
  /// The widget to display for mobile screens
  final Widget mobile;

  /// The widget to display for tablet screens
  final Widget? tablet;

  /// The widget to display for desktop screens
  final Widget? desktop;

  /// Optional custom breakpoint provider
  final BreakpointProvider? breakpointProvider;

  /// Creates an [AdaptiveIndexedStack]
  const AdaptiveIndexedStack({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.breakpointProvider,
  });

  /// Gets the index for the current screen type
  int _indexFor(DeviceScreenType screenType) {
    switch (screenType) {
      case DeviceScreenType.mobile:
        return 0;
      case DeviceScreenType.tablet:
        return 1;
      case DeviceScreenType.desktop:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final provider = breakpointProvider ?? const DefaultBreakpointProvider();
      final screenType = provider.getScreenType(constraints.maxWidth);

      final children = <Widget>[
        mobile,
        tablet ?? mobile,
        desktop ?? tablet ?? mobile,
      ];

      return IndexedStack(
        index: _indexFor(screenType),
        children: children,
      );
    });
  }
}
