// FILE: lib/src/device_screen_type.dart
/// {@template responsive_ui.device_screen_type}
/// An enumeration of the different screen types based on their width.
///
/// This is the core concept used to select the appropriate value
/// from a [ResponsiveValue<T>].
/// {@endtemplate}
enum DeviceScreenType {
  /// Layout for mobile screens, typically phones.
  mobile,

  /// Layout for tablet screens.
  tablet,

  /// Layout for desktop screens, typically laptops and monitors.
  desktop,
}

/// Extension methods for [DeviceScreenType]
extension DeviceScreenTypeX on DeviceScreenType {
  /// Returns true if the screen type is mobile
  bool get isMobile => this == DeviceScreenType.mobile;

  /// Returns true if the screen type is tablet
  bool get isTablet => this == DeviceScreenType.tablet;

  /// Returns true if the screen type is desktop
  bool get isDesktop => this == DeviceScreenType.desktop;
}