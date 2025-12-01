import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// A widget that renders a glare (shine) effect overlay on the credit card.
///
/// This widget creates a gradient overlay that simulates light reflection
/// on the card surface. The glare position rotates based on the card's tilt
/// angle, creating a realistic shine effect that follows the card's movement.
///
/// The glare is implemented as a linear gradient with decreasing opacity
/// from the light source, creating a subtle but effective shine appearance.
///
/// This is an internal widget used by [CardBackground] and is not intended
/// for direct use in application code.
class GlareEffectWidget extends StatelessWidget {
  /// Creates a glare effect widget.
  ///
  /// The [child] parameter is required.
  const GlareEffectWidget({
    required this.child,
    this.glarePosition,
    this.border,
    super.key,
  });

  /// The child widget to display beneath the glare overlay.
  final Widget child;

  /// Optional border to apply to the glare container.
  ///
  /// Should match the border of the parent card for consistent appearance.
  final BoxBorder? border;

  /// The rotation angle of the glare gradient in radians.
  ///
  /// When null, no glare effect is displayed. The angle determines the
  /// direction from which the "light" appears to shine on the card.
  final double? glarePosition;

  /// The gradient colors used for the glare effect.
  ///
  /// Uses semi-transparent white colors with decreasing opacity.
  static final List<Color> _glareGradientColors = <Color>[
    AppConstants.defaultGlareColor.withOpacity(0.1),
    AppConstants.defaultGlareColor.withOpacity(0.07),
    AppConstants.defaultGlareColor.withOpacity(0.05),
  ];

  /// The stops for the glare gradient.
  ///
  /// Defines where each color in [_glareGradientColors] is positioned.
  static const List<double> _gradientStop = <double>[0.1, 0.3, 0.6];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child,
        if (glarePosition != null)
          Positioned.fill(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: border,
                gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  colors: _glareGradientColors,
                  stops: _gradientStop,
                  transform: GradientRotation(glarePosition!),
                ),
              ),
            ),
          )
      ],
    );
  }
}
