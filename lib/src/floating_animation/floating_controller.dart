import 'dart:math';

import 'package:flutter/rendering.dart';

import '../utils/constants.dart';
import 'floating_event.dart';

/// Controller for managing floating card animation transformations.
///
/// This controller maintains the current x and y rotation angles and
/// provides the transformation logic for the floating effect. It handles
/// both gyroscope-based (mobile) and pointer-based (web/desktop) inputs.
///
/// The controller converts [FloatingEvent] data into [Matrix4]
/// transformations that can be applied to the credit card widget.
class FloatingController {
  /// Creates a floating controller with custom configuration.
  ///
  /// The [maximumAngle] limits how far the card can tilt.
  /// The [restBackVelocity] controls how quickly the card returns to
  /// its neutral position.
  FloatingController({
    required this.maximumAngle,
    this.restBackVelocity,
    this.isGyroscopeAvailable = false,
  });

  /// Creates a floating controller with predefined default values.
  ///
  /// Uses [AppConstants.defaultRestBackVel] for rest back velocity
  /// and [AppConstants.defaultMaximumAngle] for maximum angle.
  FloatingController.predefined()
      : restBackVelocity = AppConstants.defaultRestBackVel,
        maximumAngle = AppConstants.defaultMaximumAngle,
        isGyroscopeAvailable = false;

  /// Whether gyroscope data is available on the current device.
  ///
  /// When true, the controller processes gyroscope events for relative motion.
  /// When false, it processes pointer events for absolute positioning.
  bool isGyroscopeAvailable;

  /// The maximum angle (in radians) the card can tilt in any direction.
  ///
  /// This limits the rotation to prevent extreme tilting that could
  /// distort the card appearance.
  double maximumAngle;

  /// The current X rotation angle in radians.
  ///
  /// Positive values tilt the card top away from the viewer.
  double x = 0;

  /// The current Y rotation angle in radians.
  ///
  /// Positive values tilt the card right side toward the viewer.
  double y = 0;

  /// The velocity at which the card returns to its neutral position.
  ///
  /// Values should be between 0 and 1. Higher values make the card
  /// return more quickly to its resting position.
  double? restBackVelocity;

  /// The computed rest-back factor used for gradual return animation.
  ///
  /// Calculated from [restBackVelocity] and used internally to lerp
  /// the card back to its neutral position.
  double get restBackFactor {
    if (restBackVelocity == null) {
      return 1;
    } else {
      const double restBackVelRange =
          AppConstants.maxRestBackVel - AppConstants.minRestBackVel;
      final double adjusted =
          AppConstants.minRestBackVel + (restBackVelocity! * restBackVelRange);
      return 1 - adjusted;
    }
  }

  /// Clamps the [x] and [y] rotation values to stay within [maximumAngle].
  ///
  /// This prevents the card from tilting beyond the configured limits,
  /// ensuring the visual effect remains pleasant and the card stays readable.
  void boundAngle() {
    x = min(maximumAngle / 2, max(-maximumAngle / 2, x));
    y = min(maximumAngle / 2, max(-maximumAngle / 2, y));
  }

  /// Transforms the rotation angles based on a [FloatingEvent] and returns
  /// a transformation matrix.
  ///
  /// The returned [Matrix4] includes perspective, rotation, and translation
  /// components that create the floating effect.
  ///
  /// If [shouldAvoid] is true or [event] is null, returns an identity matrix
  /// with only perspective applied (no rotation or translation).
  ///
  /// The transformation differs based on input type:
  /// - Gyroscope: Applies incremental rotation with rest-back factor
  /// - Pointer: Applies absolute positioning based on cursor location
  Matrix4 transform(
    FloatingEvent? event, {
    /// Denotes whether to avoid applying any transformation.
    bool shouldAvoid = false,
  }) {
    final Matrix4 matrix = Matrix4.identity()..setEntry(3, 2, 0.001);

    if (shouldAvoid || event == null) {
      return matrix;
    }

    if (isGyroscopeAvailable) {
      x += event.x * 0.016;
      y -= event.y * 0.016;

      boundAngle();

      // Apply the velocity to float the card.
      x *= restBackFactor;
      y *= restBackFactor;
    } else {
      x = event.x * 0.2;
      y = event.y * 0.2;
    }

    // Rotate the matrix by the resulting x and y values.
    matrix
      ..rotateX(x)
      ..rotateY(y)
      ..translate(y * -90, x * 45);

    return matrix;
  }
}
