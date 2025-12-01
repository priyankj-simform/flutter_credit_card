import 'package:flutter/material.dart';

import 'floating_animation/floating_event.dart';
import 'utils/typedefs.dart';

/// A widget that applies floating animation transformation to its child.
///
/// This widget listens to a stream of [FloatingEvent]s (from gyroscope or
/// mouse movement) and transforms its child widget accordingly, creating
/// a floating/tilting effect.
///
/// When [isEnabled] is false, the child is rendered without any transformation.
///
/// This is an internal widget used by [CreditCardWidget] and is not intended
/// for direct use in application code.
///
/// ## Example
///
/// ```dart
/// FloatAnimationBuilder(
///   isEnabled: true,
///   stream: floatingEventStream,
///   onEvent: (event) => controller.transform(event),
///   child: () => CardContent(),
/// )
/// ```
class FloatAnimationBuilder extends StatelessWidget {
  /// Creates a float animation builder.
  ///
  /// All parameters are required.
  const FloatAnimationBuilder({
    required this.isEnabled,
    required this.stream,
    required this.onEvent,
    required this.child,
    super.key,
  });

  /// Whether the floating animation is enabled.
  ///
  /// When false, the [child] is rendered without transformation.
  final bool isEnabled;

  /// The stream of [FloatingEvent]s that drive the animation.
  ///
  /// Events can come from device gyroscope or mouse cursor movement.
  final Stream<FloatingEvent> stream;

  /// Callback that converts a [FloatingEvent] into a transformation matrix.
  ///
  /// This callback is called for each event in the stream and should return
  /// a [Matrix4] representing the desired transformation.
  final FloatEventCallback onEvent;

  /// A callback that returns the child widget to be transformed.
  ///
  /// Using a callback allows the child to be rebuilt when the stream emits
  /// new events.
  final WidgetCallback child;

  @override
  Widget build(BuildContext context) {
    return isEnabled
        ? StreamBuilder<FloatingEvent>(
            stream: stream,
            builder: (
              BuildContext context,
              AsyncSnapshot<FloatingEvent> snapshot,
            ) =>
                Transform(
              transform: onEvent(snapshot.data),
              alignment: FractionalOffset.center,
              child: child(),
            ),
          )
        : child();
  }
}
