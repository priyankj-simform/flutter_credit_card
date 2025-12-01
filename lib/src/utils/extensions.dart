import 'package:flutter/widgets.dart';

/// Extension methods for nullable [String] values.
///
/// Provides convenient null-safe checks for string emptiness.
extension NullableStringExtension on String? {
  /// Returns `true` if the string is null or empty.
  ///
  /// ```dart
  /// String? nullStr;
  /// print(nullStr.isNullOrEmpty);  // true
  /// print(''.isNullOrEmpty);        // true
  /// print('hello'.isNullOrEmpty);   // false
  /// ```
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// Returns `true` if the string is not null and not empty.
  ///
  /// ```dart
  /// String? nullStr;
  /// print(nullStr.isNotNullAndNotEmpty);  // false
  /// print(''.isNotNullAndNotEmpty);        // false
  /// print('hello'.isNotNullAndNotEmpty);   // true
  /// ```
  bool get isNotNullAndNotEmpty => this?.isNotEmpty ?? false;
}

/// Extension methods for [Orientation] values.
///
/// Provides convenient checks for device orientation.
extension OrientationExtension on Orientation {
  /// Returns `true` if the orientation is portrait.
  bool get isPortrait => this == Orientation.portrait;

  /// Returns `true` if the orientation is landscape.
  bool get isLandscape => this == Orientation.landscape;
}
