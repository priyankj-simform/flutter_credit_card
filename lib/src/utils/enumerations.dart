/// Enumeration of supported credit card types.
///
/// This enum defines all the card brands that can be automatically detected
/// by the package based on card number prefixes.
///
/// The detection uses industry-standard BIN (Bank Identification Number)
/// patterns to identify the card issuer from the first several digits of
/// the card number.
///
/// See also:
/// - [detectCCType] function for automatic card type detection
/// - [CreditCardBrand] for the wrapper class used in callbacks
enum CardType {
  /// Unknown or unsupported card brand.
  ///
  /// Used when the card number prefix doesn't match any known pattern.
  otherBrand,

  /// Mastercard credit/debit card.
  ///
  /// Prefixes: 51-55, 2221-2720
  mastercard,

  /// Visa credit/debit card.
  ///
  /// Prefix: 4
  visa,

  /// RuPay card (Indian payment network).
  ///
  /// Prefixes: 60, 6521-6522
  rupay,

  /// American Express credit card.
  ///
  /// Prefixes: 34, 37
  americanExpress,

  /// UnionPay card (Chinese payment network).
  ///
  /// Prefix: 62
  unionpay,

  /// Discover credit card.
  ///
  /// Prefixes: 6011, 65, 644-649, 622126-622925
  discover,

  /// Elo card (Brazilian payment network).
  ///
  /// Various prefixes in the 4, 5, and 6 ranges
  elo,

  /// Hipercard (Brazilian payment network).
  ///
  /// Prefix: 606282
  hipercard,

  /// Mir card (Russian payment network).
  ///
  /// Prefixes: 2200-2204
  mir,
}

/// The type of motion input for floating animation.
///
/// Determines how the floating event coordinates should be interpreted
/// by the [FloatingController].
enum FloatingType {
  /// Motion data from mouse pointer or touch input.
  ///
  /// Coordinates represent absolute position relative to the widget center.
  pointer,

  /// Motion data from device gyroscope sensors.
  ///
  /// Coordinates represent rotation rates, relative to the previous reading.
  gyroscope;

  /// Whether this is a pointer-based event.
  bool get isPointer => this == pointer;

  /// Whether this is a gyroscope-based event.
  bool get isGyroscope => this == gyroscope;
}
