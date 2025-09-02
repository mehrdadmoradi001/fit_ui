// FILE: lib/src/responsive_slots.dart
import 'package:flutter/widgets.dart';
import 'breakpoints.dart';
import 'device_screen_type.dart';

/// {@template responsive_ui.responsive_slots}
/// A widget that provides a slot-based responsive layout system.
///
/// This widget allows you to define header, body, and side slots that
/// automatically rearrange themselves based on the screen size.
/// {@endtemplate}
class ResponsiveSlots extends StatelessWidget {
  /// The header slot builder
  final Widget Function(DeviceScreenType screenType) header;

  /// The body slot builder
  final Widget Function(DeviceScreenType screenType) body;

  /// The side slot builder (optional)
  final Widget Function(DeviceScreenType screenType)? side;

  /// Optional custom breakpoint provider
  final BreakpointProvider? breakpointProvider;

  /// The horizontal spacing between the body and side slots on desktop.
  /// Defaults to 16.0.
  final double desktopSideSpacing;

  /// The vertical spacing between the body and side slots on tablet.
  /// Defaults to 12.0.
  final double tabletSideSpacing;

  /// Creates a [ResponsiveSlots] widget
  const ResponsiveSlots({
    super.key,
    required this.header,
    required this.body,
    this.side,
    this.breakpointProvider,
    this.desktopSideSpacing = 16.0, // Default value
    this.tabletSideSpacing = 12.0, // Default value
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final provider = breakpointProvider ?? const DefaultBreakpointProvider();
      final screenType = provider.getScreenType(constraints.maxWidth);

      final sideWidget = side?.call(screenType);

      if (screenType == DeviceScreenType.desktop && sideWidget != null) {
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  header(screenType),
                  Expanded(child: body(screenType)),
                ],
              ),
            ),
            SizedBox(width: desktopSideSpacing),
            Expanded(
              flex: 1,
              child: sideWidget,
            ),
          ],
        );
      }

      // Tablet & mobile layout
      return Column(
        children: [
          header(screenType),
          Expanded(child: body(screenType)),
          if (sideWidget != null && screenType == DeviceScreenType.tablet)
            SizedBox(height: tabletSideSpacing),
          if (sideWidget != null && screenType != DeviceScreenType.desktop)
            sideWidget,
        ],
      );
    });
  }
}
