// FILE: lib/src/responsive_value.dart
import 'device_screen_type.dart';

/// {@template responsive_ui.responsive_value}
/// A generic class that holds a value for each screen type.
///
/// This allows for defining responsive values (like padding, font size, etc.)
/// in a clean, declarative way. It includes an intelligent fallback mechanism:
/// if a value for a larger screen type is not provided, it falls back to the
/// next smaller one.
///
/// ### Example
/// ```dart
/// // Font size that is 14 on mobile, 16 on tablet, and 18 on desktop.
/// const responsiveFontSize = ResponsiveValue(14, tablet: 16, desktop: 18);
///
/// // Padding that is 16 on all devices, but 24 on tablet and desktop.
/// const responsivePadding = ResponsiveValue(16, tablet: 24);
///
/// // A widget that is only shown on mobile and tablet.
/// const responsiveWidget = ResponsiveValue(MobileWidget(), tablet: TabletWidget());
/// ```
/// {@endtemplate}
class ResponsiveValue<T> {
  /// The value for the mobile layout. This value is required.
  final T mobile;

  /// The value for the tablet layout. If null, [mobile] is used.
  final T? tablet;

  /// The value for the desktop layout. If null, [tablet] or [mobile] is used.
  final T? desktop;

  /// Creates a responsive value configuration.
  ///
  /// Only [mobile] is required. If [tablet] or [desktop] are omitted,
  /// the value of the next smaller screen size is used as a fallback.
  const ResponsiveValue(this.mobile, {this.tablet, this.desktop});

  /// Resolves the appropriate value based on the given [DeviceScreenType].
  ///
  /// Implements a fallback logic:
  /// - For [DeviceScreenType.desktop], returns [desktop] ?? [tablet] ?? [mobile].
  /// - For [DeviceScreenType.tablet], returns [tablet] ?? [mobile].
  /// - For [DeviceScreenType.mobile], returns [mobile].
  T resolve(DeviceScreenType screenType) {
    switch (screenType) {
      case DeviceScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceScreenType.tablet:
        return tablet ?? mobile;
      case DeviceScreenType.mobile:
        return mobile;
    }
  }

  /// Creates a new [ResponsiveValue] whose values are created by applying
  /// a transformation function ([mapper]) to each value of this [ResponsiveValue].
  ResponsiveValue<R> map<R>(R Function(T value) mapper) {
    final localTablet = tablet;
    final localDesktop = desktop;

    return ResponsiveValue<R>(
      mapper(mobile),
      tablet: localTablet!= null? mapper(localTablet) : null,
      desktop: localDesktop!= null? mapper(localDesktop) : null,
    );
  }

  @override
  String toString() => 'ResponsiveValue(mobile: $mobile, tablet: $tablet, desktop: $desktop)';
}