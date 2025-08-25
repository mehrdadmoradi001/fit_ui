// FILE: lib/src/breakpoints.dart
import 'device_screen_type.dart';

/// {@template responsive_ui.breakpoints}
/// Defines the standard breakpoints for different screen sizes.
/// These values are used to determine the current device screen type
/// based on the available width (local constraints).
///
/// You can override the default values by implementing your own
/// [BreakpointProvider] and using it in the responsive widgets.
/// {@endtemplate}
abstract class AppBreakpoints {
  /// The maximum width for a mobile layout.
  static const double mobile = 600;

  /// The maximum width for a tablet layout.
  static const double tablet = 950;
}

/// A provider interface for custom breakpoints.
/// Implement this class to define your own breakpoint logic.
abstract class BreakpointProvider {
  DeviceScreenType getScreenType(double width);
}

/// The default implementation of [BreakpointProvider] using [AppBreakpoints].
class DefaultBreakpointProvider implements BreakpointProvider {
  const DefaultBreakpointProvider();

  @override
  DeviceScreenType getScreenType(double width) {
    if (width > AppBreakpoints.tablet) {
      return DeviceScreenType.desktop;
    } else if (width > AppBreakpoints.mobile) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.mobile;
    }
  }
}