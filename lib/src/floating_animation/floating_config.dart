import 'dart:ui';

import '../utils/constants.dart';

/// Configuration for the floating card animation effect.
///
/// This class controls the visual effects applied to the credit card
/// when floating animation is enabled. The floating effect makes the card
/// tilt and move based on device gyroscope data or mouse cursor position.
///
/// ## Basic Usage
///
/// ```dart
/// CreditCardWidget(
///   enableFloatingCard: true,
///   floatingConfig: FloatingConfig(
///     isGlareEnabled: true,
///     isShadowEnabled: true,
///   ),
/// )
/// ```
///
/// ## Custom Shadow Configuration
///
/// ```dart
/// CreditCardWidget(
///   enableFloatingCard: true,
///   floatingConfig: FloatingConfig(
///     isGlareEnabled: true,
///     isShadowEnabled: true,
///     shadowConfig: FloatingShadowConfig(
///       offset: Offset(0, 10),
///       color: Colors.black54,
///       blurRadius: 15,
///     ),
///   ),
/// )
/// ```
class FloatingConfig {
  /// Creates a floating configuration.
  ///
  /// By default, both glare and shadow effects are enabled.
  const FloatingConfig({
    this.isGlareEnabled = true,
    this.isShadowEnabled = true,
    this.shadowConfig = const FloatingShadowConfig(),
  });

  /// Whether to display a glare (shine) effect on the card.
  ///
  /// When enabled, a gradient overlay follows the card's tilt direction,
  /// creating a reflective shine effect.
  ///
  /// Defaults to `true`.
  final bool isGlareEnabled;

  /// Whether to display a shadow beneath the card.
  ///
  /// When enabled, a dynamic shadow is rendered that moves based on
  /// the card's tilt, enhancing the 3D floating effect.
  ///
  /// Defaults to `true`.
  final bool isShadowEnabled;

  /// Configuration for the floating shadow appearance.
  ///
  /// Only used when [isShadowEnabled] is `true`.
  final FloatingShadowConfig shadowConfig;

  @override
  bool operator ==(Object other) {
    return other is FloatingConfig &&
        other.isGlareEnabled == isGlareEnabled &&
        other.isShadowEnabled == isShadowEnabled &&
        other.shadowConfig == shadowConfig;
  }

  @override
  int get hashCode => Object.hash(
        isGlareEnabled,
        isShadowEnabled,
        shadowConfig,
      );
}

/// Configuration for the shadow displayed beneath the floating card.
///
/// This class defines the appearance of the shadow that appears below
/// the credit card when floating animation is enabled.
///
/// ## Example
///
/// ```dart
/// FloatingShadowConfig(
///   offset: Offset(0, 10),
///   color: Colors.black54,
///   blurRadius: 15,
/// )
/// ```
class FloatingShadowConfig {
  /// Creates a floating shadow configuration.
  ///
  /// Default values provide a subtle shadow effect suitable for most
  /// card backgrounds.
  const FloatingShadowConfig({
    this.offset = const Offset(0, 8),
    this.color = AppConstants.floatingShadowColor,
    this.blurRadius = AppConstants.minBlurRadius,
  });

  /// The base offset of the shadow from the card.
  ///
  /// The actual shadow position is dynamically adjusted based on card tilt.
  /// Defaults to `Offset(0, 8)`.
  final Offset offset;

  /// The blur radius of the shadow.
  ///
  /// Larger values create a softer, more diffuse shadow.
  /// Defaults to [AppConstants.minBlurRadius] (10).
  final double blurRadius;

  /// The color of the shadow.
  ///
  /// Defaults to [AppConstants.floatingShadowColor] (semi-transparent black).
  final Color color;

  @override
  bool operator ==(Object other) {
    return other is FloatingShadowConfig &&
        other.color == color &&
        other.blurRadius == blurRadius &&
        other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(offset, color, blurRadius);
}
