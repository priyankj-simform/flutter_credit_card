import 'package:flutter/material.dart';

/// A widget that applies a 3D flip animation to its child.
///
/// This widget wraps its child in a transform that rotates around the Y-axis,
/// creating a card flip effect. It uses perspective transformation to give
/// a realistic 3D appearance.
///
/// The animation value should range from 0 to π (pi) for a complete flip,
/// with 0 being the front view and π being the back view.
///
/// This is an internal widget used by [CreditCardWidget] and is not intended
/// for direct use in application code.
///
/// ## Example
///
/// ```dart
/// FlipAnimationBuilder(
///   animation: _flipAnimation,
///   child: CardFrontContent(),
/// )
/// ```
class FlipAnimationBuilder extends StatelessWidget {
  /// Creates a flip animation builder.
  ///
  /// The [child] and [animation] parameters are required.
  const FlipAnimationBuilder({
    required this.child,
    required this.animation,
    super.key,
  });

  /// The widget to apply the flip animation to.
  final Widget child;

  /// The animation that drives the flip transformation.
  ///
  /// Values should typically range from 0 to π for front-to-back rotation.
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}
