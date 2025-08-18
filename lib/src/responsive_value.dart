import 'device_screen_type.dart';

/// A generic class that holds a value for each screen type.
///
/// This allows for defining responsive values (like padding, font size, etc.)
/// in a clean, declarative way. It includes an intelligent fallback mechanism:
/// if a value for a larger screen type is not provided, it falls back to the next smaller one.
class ResponsiveValue<T> {
  /// The value for the. This value is required.
  final T mobile;

  /// The value for the. If null, [mobile] is used.
  final T? tablet;

  /// The value for the. If null, [tablet] or [mobile] is used.
  final T? desktop;

  /// Creates a responsive value configuration.
  ///
  /// Only [mobile] is required. If [tablet] or [desktop] are omitted,
  /// the value of the next smaller screen size is used as a fallback.
  const ResponsiveValue(this.mobile, {this.tablet, this.desktop});

  /// Resolves the appropriate value based on the given.
  ///
  /// Implements a fallback logic:
  /// - For, returns [desktop]?? [tablet]?? [mobile].
  /// - For, returns [tablet]?? [mobile].
  /// - For, returns [mobile].
  T resolve(DeviceScreenType screenType) {
    switch (screenType) {
      case DeviceScreenType.desktop:
        return desktop?? tablet?? mobile;
      case DeviceScreenType.tablet:
        return tablet?? mobile;
      case DeviceScreenType.mobile:
        return mobile;
    }
  }
}