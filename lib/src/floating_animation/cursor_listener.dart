import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/enumerations.dart';
import 'floating_event.dart';

/// A widget that listens to mouse cursor movement and generates floating events.
///
/// This widget detects mouse hover events over the credit card area and
/// converts cursor position into [FloatingEvent]s, which are then used
/// to create a floating/tilting animation effect on the card.
///
/// The widget implements smooth entry and exit animations by gradually
/// adjusting the intensity factor when the cursor enters or leaves the area.
///
/// This is an internal widget used by [CreditCardWidget] for web/desktop
/// platforms where gyroscope data is not available.
class CursorListener extends StatefulWidget {
  /// Creates a cursor listener widget.
  ///
  /// All parameters are required.
  const CursorListener({
    required this.onPositionChange,
    required this.height,
    required this.width,
    required this.padding,
    super.key,
  });

  /// The padding applied around the detection area.
  ///
  /// Used to calculate clamping bounds when the card widget is larger
  /// than the breakpoint.
  final double padding;

  /// The height of the area where cursor movement is detected.
  final double height;

  /// The width of the area where cursor movement is detected.
  final double width;

  /// Callback invoked when a cursor position change is detected.
  ///
  /// The callback receives a [FloatingEvent] containing the calculated
  /// x and y rotation values based on cursor position.
  final ValueChanged<FloatingEvent> onPositionChange;

  @override
  State<CursorListener> createState() => _CursorListenerState();
}

class _CursorListenerState extends State<CursorListener> {
  /// The last recorded cursor offset, used for calculating deltas
  /// and throttling events.
  Offset lastOffset = Offset.zero;

  /// The timestamp of the last processed pointer event, used for throttling.
  DateTime lastPointerEvent = DateTime.now();

  /// The current intensity factor for smooth animation transitions.
  ///
  /// Animates from 0 (idle) to 1 (fully active) when cursor enters,
  /// and back to 0 when cursor exits.
  double intensityFactor = 0;

  /// Timer that handles progressive intensity factor changes for smooth
  /// entry and exit animations.
  Timer? velocityTimer;

  /// Cached value of padding * 2 for performance.
  late double surroundedPadding = widget.padding * 2;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (_) => _onCursorEnter(),
      onExit: (_) => _onCursorExit(),
      onHover: (PointerHoverEvent details) {
        _onCursorMove(details.localPosition);
      },
    );
  }

  @override
  void dispose() {
    velocityTimer?.cancel();
    super.dispose();
  }

  void _onCursorMove(Offset position) {
    if (DateTime.now().difference(lastPointerEvent) < AppConstants.fps60) {
      /// Drop event since it occurs too early.
      return;
    }

    double x = 0.0;
    double y = 0.0;

    // Compute the fractional offset.
    x = (position.dy - (widget.height / 2)) / widget.height;
    y = -(position.dx - (widget.width / 2)) / widget.width;

    // Apply the intensity factor.
    x *= intensityFactor;
    y *= intensityFactor;

    // Calculate the maximum allowable offset while staying within the
    // screen bounds when the card widget is larger than
    // [AppConstants.webBreakPoint].
    if (widget.width > AppConstants.floatWebBreakPoint) {
      try {
        final double clampingFactor = surroundedPadding / widget.height;

        if (!clampingFactor.isNaN && !clampingFactor.isInfinite) {
          // Clamp the x and y values to stay within screen bounds.
          x = x.clamp(-clampingFactor, clampingFactor);
          y = y.clamp(-clampingFactor, clampingFactor);
        }
      } catch (_) {
        // Ignore clamping if it causes an error.
      }
    }

    // Notify the position change.
    widget.onPositionChange(
      FloatingEvent(
        type: FloatingType.pointer,
        x: x,
        y: y,
      ),
    );

    // Store the previous values.
    lastPointerEvent = DateTime.now();
    lastOffset = Offset(position.dx, position.dy);
  }

  /// Animate the intensity factor to 1, to smoothly get to the pointer's
  /// position.
  Future<void> _onCursorEnter() async {
    _cancelVelocityTimer();

    velocityTimer = Timer.periodic(
      AppConstants.fps60Offset,
      (_) {
        if (intensityFactor < 1) {
          if (intensityFactor <= 0.05) {
            intensityFactor = 0.05;
          }
          intensityFactor = min(1, intensityFactor * 1.2);
          _onCursorMove(lastOffset);
        } else {
          _cancelVelocityTimer();
        }
      },
    );
  }

  /// Animate the intensity factor to 0, to smoothly get back to the initial
  /// position.
  Future<void> _onCursorExit() async {
    _cancelVelocityTimer();

    velocityTimer = Timer.periodic(
      AppConstants.fps60Offset,
      (_) {
        if (intensityFactor > 0.05) {
          intensityFactor = max(0, intensityFactor * 0.95);
          _onCursorMove(lastOffset);
        } else {
          _cancelVelocityTimer();
        }
      },
    );
  }

  /// Cancels the velocity timer.
  void _cancelVelocityTimer() {
    velocityTimer?.cancel();
    velocityTimer = null;
  }
}
