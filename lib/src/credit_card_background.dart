import 'dart:ui';

import 'package:flutter/material.dart';

import 'floating_animation/floating_config.dart';
import 'floating_animation/floating_controller.dart';
import 'floating_animation/glare_effect_widget.dart';
import 'models/glassmorphism_config.dart';
import 'utils/constants.dart';
import 'utils/extensions.dart';

/// A widget that renders the background of a credit card.
///
/// This widget provides the visual background for [CreditCardWidget],
/// supporting multiple background options including solid colors, gradients,
/// local asset images, and network images. It also supports glassmorphism
/// effects and floating shadow animations.
///
/// The widget handles:
/// - Responsive sizing based on screen orientation and constraints
/// - Gradient backgrounds with customizable colors
/// - Asset and network image backgrounds
/// - Glassmorphism blur effects via [Glassmorphism]
/// - Dynamic shadow positioning for floating animation
/// - Glare effects for enhanced visual appeal
///
/// This is an internal widget used by [CreditCardWidget] and is not intended
/// for direct use in application code.
class CardBackground extends StatelessWidget {
  /// Creates a card background widget.
  ///
  /// The [backgroundGradientColor], [child], and [padding] parameters are
  /// required.
  ///
  /// Only one of [backgroundImage] or [backgroundNetworkImage] can be provided,
  /// not both.
  const CardBackground({
    required this.backgroundGradientColor,
    required this.child,
    required this.padding,
    this.backgroundImage,
    this.backgroundNetworkImage,
    this.width,
    this.height,
    this.glassmorphismConfig,
    this.border,
    this.floatingController,
    this.glarePosition,
    this.shadowConfig,
    super.key,
  }) : assert(
          backgroundImage == null || backgroundNetworkImage == null,
          'You can\'t use network image & asset image at same time as card'
          ' background',
        );

  /// Path to a local asset image to use as the card background.
  ///
  /// This should be a valid asset path from your app's assets folder.
  /// Cannot be used together with [backgroundNetworkImage].
  final String? backgroundImage;

  /// URL of a network image to use as the card background.
  ///
  /// This should be a valid HTTP/HTTPS URL pointing to an image.
  /// Cannot be used together with [backgroundImage].
  final String? backgroundNetworkImage;

  /// The child widget to display on top of the background.
  ///
  /// Typically contains the credit card details layout.
  final Widget child;

  /// The gradient to apply to the background when no image is provided.
  ///
  /// This gradient is also used when [glassmorphismConfig] is null.
  final Gradient backgroundGradientColor;

  /// Configuration for applying glassmorphism (frosted glass) effects.
  ///
  /// When provided, applies a blur filter and gradient overlay to create
  /// the glassmorphism visual effect.
  final Glassmorphism? glassmorphismConfig;

  /// The width of the card background.
  ///
  /// If null, the widget expands to fill available width.
  final double? width;

  /// The height of the card background.
  ///
  /// If null, the height is calculated based on the credit card aspect ratio.
  final double? height;

  /// The padding applied around the card.
  final double padding;

  /// The border to apply to the card.
  final BoxBorder? border;

  /// Controller for the floating animation transformation.
  ///
  /// Used to calculate shadow offset based on card rotation.
  final FloatingController? floatingController;

  /// The rotation angle for the glare effect gradient.
  ///
  /// When not null, displays a glare overlay that follows the card movement.
  final double? glarePosition;

  /// Configuration for the shadow displayed beneath the card.
  ///
  /// Only applied when [floatingController] is also provided.
  final FloatingShadowConfig? shadowConfig;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Orientation orientation = mediaQueryData.orientation;
    final Size screenSize = mediaQueryData.size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double screenWidth = constraints.maxWidth.isInfinite
            ? screenSize.width
            : constraints.maxWidth;
        final double implicitHeight = orientation.isPortrait
            ? ((width ?? screenWidth) - (padding * 2)) *
                AppConstants.creditCardAspectRatio
            : screenSize.height / 2;
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(padding),
              width: width ?? screenWidth,
              height: height ?? implicitHeight,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: AppConstants.creditCardBorderRadius,
                boxShadow: shadowConfig != null && floatingController != null
                    ? <BoxShadow>[
                        BoxShadow(
                          blurRadius: shadowConfig!.blurRadius,
                          color: shadowConfig!.color,
                          offset: shadowConfig!.offset +
                              Offset(
                                floatingController!.y * 100,
                                -floatingController!.x * 100,
                              ),
                        ),
                      ]
                    : null,
                border: border,
                gradient:
                    glassmorphismConfig?.gradient ?? backgroundGradientColor,
                image: backgroundImage?.isNotEmpty ?? false
                    ? DecorationImage(
                        image: ExactAssetImage(backgroundImage!),
                        fit: BoxFit.fill,
                      )
                    : backgroundNetworkImage?.isNotEmpty ?? false
                        ? DecorationImage(
                            image: NetworkImage(backgroundNetworkImage!),
                            fit: BoxFit.fill,
                          )
                        : null,
              ),
              child: GlareEffectWidget(
                border: border,
                glarePosition: glarePosition,
                child: glassmorphismConfig == null
                    ? child
                    : BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: glassmorphismConfig!.blurX,
                          sigmaY: glassmorphismConfig!.blurY,
                        ),
                        child: child,
                      ),
              ),
            ),
            if (glassmorphismConfig != null)
              Padding(
                padding: EdgeInsets.all(padding),
                child: _GlassmorphicBorder(
                  width: width ?? screenWidth,
                  height: height ?? implicitHeight,
                ),
              ),
          ],
        );
      },
    );
  }
}

/// A widget that renders the glassmorphism border effect.
///
/// This widget draws a subtle gradient border around the card to enhance
/// the glassmorphism appearance.
class _GlassmorphicBorder extends StatelessWidget {
  /// Creates a glassmorphic border widget.
  _GlassmorphicBorder({
    required this.height,
    required this.width,
  }) : _painter = _GradientPainter(strokeWidth: 2, radius: 10);
  final _GradientPainter _painter;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      size: MediaQuery.of(context).size,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: AppConstants.creditCardBorderRadius,
        ),
        width: width,
        height: height,
      ),
    );
  }
}

/// A custom painter that draws the gradient border for glassmorphism effect.
///
/// This painter creates a subtle gradient outline around the card edges
/// to simulate glass reflections.
class _GradientPainter extends CustomPainter {
  /// Creates a gradient painter with the specified stroke width and corner
  /// radius.
  _GradientPainter({required this.strokeWidth, required this.radius});

  final double radius;
  final double strokeWidth;
  final Paint paintObject = Paint();
  final Paint paintObject2 = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final LinearGradient gradient = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: <Color>[
          Colors.white.withAlpha(50),
          Colors.white.withAlpha(55),
          Colors.white.withAlpha(50),
        ],
        stops: const <double>[
          0.06,
          0.95,
          1
        ]);
    final RRect innerRect2 = RRect.fromRectAndRadius(
        Rect.fromLTRB(strokeWidth, strokeWidth, size.width - strokeWidth,
            size.height - strokeWidth),
        Radius.circular(radius - strokeWidth));

    final RRect outerRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(0, 0, size.width, size.height), Radius.circular(radius));
    paintObject.shader = gradient.createShader(Offset.zero & size);

    final Path outerRectPath = Path()..addRRect(outerRect);
    final Path innerRectPath2 = Path()..addRRect(innerRect2);
    canvas.drawPath(
        Path.combine(
            PathOperation.difference,
            outerRectPath,
            Path.combine(
                PathOperation.intersect, outerRectPath, innerRectPath2)),
        paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
