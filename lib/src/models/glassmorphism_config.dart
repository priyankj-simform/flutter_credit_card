import 'package:flutter/material.dart';

/// Configuration for applying a glassmorphism (frosted glass) effect to the
/// credit card.
///
/// Glassmorphism is a design style that features a semi-transparent background
/// with blur, creating a "frosted glass" appearance. This class allows you to
/// configure the blur intensity and gradient overlay.
///
/// ## Default Configuration
///
/// ```dart
/// CreditCardWidget(
///   // ... other parameters
///   glassmorphismConfig: Glassmorphism.defaultConfig(),
/// )
/// ```
///
/// ## Custom Configuration
///
/// ```dart
/// CreditCardWidget(
///   // ... other parameters
///   glassmorphismConfig: Glassmorphism(
///     blurX: 10.0,
///     blurY: 10.0,
///     gradient: LinearGradient(
///       begin: Alignment.topLeft,
///       end: Alignment.bottomRight,
///       colors: [
///         Colors.white.withAlpha(20),
///         Colors.white.withAlpha(10),
///       ],
///     ),
///   ),
/// )
/// ```
class Glassmorphism {
  /// Creates a glassmorphism configuration with custom blur and gradient values.
  ///
  /// All parameters are required.
  Glassmorphism({
    required this.blurX,
    required this.blurY,
    required this.gradient,
  });

  /// Creates a default glassmorphism configuration.
  ///
  /// Default values:
  /// - [blurX]: 8.0
  /// - [blurY]: 16.0
  /// - [gradient]: A subtle grey gradient
  factory Glassmorphism.defaultConfig() {
    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.grey.withAlpha(20),
        Colors.grey.withAlpha(20),
      ],
      stops: const <double>[
        0.3,
        0,
      ],
    );
    return Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient);
  }

  /// The horizontal blur intensity (sigma X) for the backdrop filter.
  ///
  /// Higher values create more blur in the horizontal direction.
  final double blurX;

  /// The vertical blur intensity (sigma Y) for the backdrop filter.
  ///
  /// Higher values create more blur in the vertical direction.
  final double blurY;

  /// The gradient overlay applied on top of the blurred background.
  ///
  /// This gradient adds color tinting to the glassmorphism effect.
  /// Use semi-transparent colors for best results.
  final Gradient gradient;
}
