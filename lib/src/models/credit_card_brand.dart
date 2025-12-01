import '../utils/enumerations.dart';

/// Represents the detected brand/type of a credit card.
///
/// This class wraps a [CardType] value and is passed to the
/// [CreditCardWidget.onCreditCardWidgetChange] callback whenever the card
/// type changes based on the entered card number.
///
/// ## Example
///
/// ```dart
/// CreditCardWidget(
///   // ... other parameters
///   onCreditCardWidgetChange: (CreditCardBrand brand) {
///     print('Detected card type: ${brand.brandName}');
///   },
/// )
/// ```
///
/// See also:
/// - [CardType] for the enumeration of supported card types.
class CreditCardBrand {
  /// Creates a credit card brand instance.
  ///
  /// The [brandName] can be null if the card type could not be determined.
  CreditCardBrand(this.brandName);

  /// The detected card type/brand.
  ///
  /// This value is automatically determined based on the card number prefix
  /// using industry-standard BIN (Bank Identification Number) patterns.
  ///
  /// Common values include:
  /// - [CardType.visa]
  /// - [CardType.mastercard]
  /// - [CardType.americanExpress]
  /// - [CardType.discover]
  /// - [CardType.otherBrand] (when type cannot be determined)
  CardType? brandName;
}
