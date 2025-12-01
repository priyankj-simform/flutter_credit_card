/// A Flutter package for displaying and entering credit card details with
/// animations.
///
/// This library provides a comprehensive set of widgets and utilities for
/// building credit card UIs in Flutter applications. Key features include:
///
/// - [CreditCardWidget]: A visually appealing credit card UI with flip
///   animation, glassmorphism effects, and floating animation support.
/// - [CreditCardForm]: A form widget for capturing credit card details with
///   built-in validation.
/// - Auto-detection of card type (Visa, Mastercard, American Express, etc.)
///   based on card number prefixes.
/// - Customizable appearance with support for custom card type icons,
///   background images, and glassmorphism effects.
///
/// ## Getting Started
///
/// Add the package to your `pubspec.yaml`:
///
/// ```yaml
/// dependencies:
///   flutter_credit_card: ^4.1.0
/// ```
///
/// Import the library:
///
/// ```dart
/// import 'package:flutter_credit_card/flutter_credit_card.dart';
/// ```
///
/// ## Basic Usage
///
/// ```dart
/// CreditCardWidget(
///   cardNumber: cardNumber,
///   expiryDate: expiryDate,
///   cardHolderName: cardHolderName,
///   cvvCode: cvvCode,
///   showBackView: isCvvFocused,
///   onCreditCardWidgetChange: (CreditCardBrand brand) {},
/// )
/// ```
///
/// See also:
/// - [CreditCardWidget] for displaying the credit card UI.
/// - [CreditCardForm] for capturing credit card input.
/// - [Glassmorphism] for applying glassmorphism effects.
/// - [FloatingConfig] for configuring floating animation.
library flutter_credit_card;

export 'src/credit_card_form.dart';
export 'src/credit_card_widget.dart';
export 'src/floating_animation/floating_config.dart';
export 'src/models/credit_card_brand.dart';
export 'src/models/credit_card_model.dart';
export 'src/models/custom_card_type_icon.dart';
export 'src/models/glassmorphism_config.dart';
export 'src/models/input_configuration.dart';
export 'src/utils/enumerations.dart' show CardType;
