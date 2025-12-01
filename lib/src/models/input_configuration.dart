import 'package:flutter/material.dart';
import 'package:flutter_credit_card/src/utils/constants.dart';

/// Configuration for customizing the appearance of [CreditCardForm] input
/// fields.
///
/// This class allows you to provide custom [InputDecoration] and [TextStyle]
/// for each text field in the credit card form, enabling full control over
/// the form's visual appearance.
///
/// ## Example
///
/// ```dart
/// CreditCardForm(
///   // ... other required parameters
///   inputConfiguration: InputConfiguration(
///     cardNumberDecoration: InputDecoration(
///       border: OutlineInputBorder(),
///       labelText: 'Card Number',
///       hintText: 'XXXX XXXX XXXX XXXX',
///     ),
///     cardNumberTextStyle: TextStyle(
///       fontSize: 16,
///       color: Colors.black87,
///     ),
///     expiryDateDecoration: InputDecoration(
///       border: OutlineInputBorder(),
///       labelText: 'Expiry Date',
///       hintText: 'MM/YY',
///     ),
///     cvvCodeDecoration: InputDecoration(
///       border: OutlineInputBorder(),
///       labelText: 'CVV',
///       hintText: 'XXX',
///     ),
///     cardHolderDecoration: InputDecoration(
///       border: OutlineInputBorder(),
///       labelText: 'Card Holder',
///     ),
///   ),
/// )
/// ```
class InputConfiguration {
  /// Creates an input configuration with optional custom decorations and styles.
  ///
  /// All parameters are optional and default to simple underline-style inputs.
  const InputConfiguration({
    this.cardHolderDecoration = const InputDecoration(
      labelText: AppConstants.cardHolder,
    ),
    this.cardNumberDecoration = const InputDecoration(
      labelText: AppConstants.cardNumber,
      hintText: AppConstants.sixteenX,
    ),
    this.expiryDateDecoration = const InputDecoration(
      labelText: AppConstants.expiryDate,
      hintText: AppConstants.expiryDateShort,
    ),
    this.cvvCodeDecoration = const InputDecoration(
      labelText: AppConstants.cvv,
      hintText: AppConstants.threeX,
    ),
    this.cardNumberTextStyle,
    this.cardHolderTextStyle,
    this.expiryDateTextStyle,
    this.cvvCodeTextStyle,
  });

  /// The decoration for the card number text field.
  ///
  /// Defaults to a simple decoration with "Card Number" label and
  /// "XXXX XXXX XXXX XXXX" hint.
  final InputDecoration cardNumberDecoration;

  /// The decoration for the card holder name text field.
  ///
  /// Defaults to a simple decoration with "Card Holder" label.
  final InputDecoration cardHolderDecoration;

  /// The decoration for the expiry date text field.
  ///
  /// Defaults to a simple decoration with "Expiry Date" label and
  /// "MM/YY" hint.
  final InputDecoration expiryDateDecoration;

  /// The decoration for the CVV code text field.
  ///
  /// Defaults to a simple decoration with "CVV" label and "XXX" hint.
  final InputDecoration cvvCodeDecoration;

  /// The text style for the card number text field.
  ///
  /// If null, inherits from the current theme.
  final TextStyle? cardNumberTextStyle;

  /// The text style for the card holder name text field.
  ///
  /// If null, inherits from the current theme.
  final TextStyle? cardHolderTextStyle;

  /// The text style for the expiry date text field.
  ///
  /// If null, inherits from the current theme.
  final TextStyle? expiryDateTextStyle;

  /// The text style for the CVV code text field.
  ///
  /// If null, inherits from the current theme.
  final TextStyle? cvvCodeTextStyle;
}
