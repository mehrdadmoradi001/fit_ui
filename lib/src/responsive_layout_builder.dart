// FILE: lib/src/responsive_layout_builder.dart
import 'package:flutter/widgets.dart';
import 'breakpoints.dart';
import 'device_screen_type.dart';

/// A builder-driven responsive layout primitive (no context required to determine type).
typedef ScreenTypeWidgetBuilder = Widget Function(
    DeviceScreenType screenType, BoxConstraints constraints);

/// {@template responsive_ui.responsive_layout_builder}
/// A widget that builds itself based on the current screen type and constraints.
///
/// This widget provides both the [DeviceScreenType] and [BoxConstraints] to the
/// builder function, allowing for highly customizable responsive layouts.
/// {@endtemplate}
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// The builder function that returns a widget based on screen type and constraints
  final ScreenTypeWidgetBuilder builder;

  /// Optional custom breakpoint provider
  final BreakpointProvider? breakpointProvider;

  /// Creates a [ResponsiveLayoutBuilder]
  const ResponsiveLayoutBuilder({
    super.key,
    required this.builder,
    this.breakpointProvider,
  });

  /// Determines the [DeviceScreenType] based on the provided width
  DeviceScreenType _getScreenType(double width) {
    final provider = breakpointProvider ?? const DefaultBreakpointProvider();
    return provider.getScreenType(width);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = _getScreenType(constraints.maxWidth);
        return builder(screenType, constraints);
      },
    );
  }
}
