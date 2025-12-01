import '../utils/enumerations.dart';

/// Represents a motion event for the floating card animation.
///
/// This class encapsulates motion data from either device gyroscope sensors
/// or mouse pointer movement, which is used to drive the card's floating
/// animation effect.
///
/// ## Event Types
///
/// - [FloatingType.gyroscope]: Motion data from device sensors. The [x], [y],
///   and [z] values represent rotation rates in radians, with each event
///   being relative to the previous position.
///
/// - [FloatingType.pointer]: Motion data from mouse cursor. The [x] and [y]
///   values represent the cursor's position relative to the widget center,
///   with each event being an absolute value. [z] is always zero.
class FloatingEvent {
  /// Creates a floating event with the specified motion data.
  ///
  /// The [type] parameter is required and determines how the coordinates
  /// should be interpreted.
  const FloatingEvent({
    required this.type,
    this.x = 0,
    this.y = 0,
    this.z = 0,
  });

  /// The X-axis motion value.
  ///
  /// For gyroscope events: rotation rate around the X-axis in radians.
  /// For pointer events: horizontal position relative to widget center.
  final double x;

  /// The Y-axis motion value.
  ///
  /// For gyroscope events: rotation rate around the Y-axis in radians.
  /// For pointer events: vertical position relative to widget center.
  final double y;

  /// The Z-axis motion value.
  ///
  /// For gyroscope events: rotation rate around the Z-axis in radians.
  /// For pointer events: always zero (2D input).
  final double z;

  /// The type of motion event.
  ///
  /// Determines how the [x], [y], and [z] coordinates should be interpreted
  /// and processed by the [FloatingController].
  final FloatingType type;
}
