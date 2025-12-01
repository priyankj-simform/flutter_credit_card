/// A model class for providing localized text labels and hints for credit
/// card form fields.
///
/// This class allows customization of the text displayed in [CreditCardForm]
/// input fields, enabling internationalization (i18n) support for the credit
/// card form.
///
/// ## Example
///
/// ```dart
/// const LocalizedText germanText = LocalizedText(
///   cardNumberLabel: 'Kartennummer',
///   cardNumberHint: 'XXXX XXXX XXXX XXXX',
///   expiryDateLabel: 'Ablaufdatum',
///   expiryDateHint: 'MM/JJ',
///   cvvLabel: 'CVV',
///   cvvHint: 'XXX',
///   cardHolderLabel: 'Karteninhaber',
///   cardHolderHint: 'Max Mustermann',
/// );
/// ```
class LocalizedText {
  /// Creates a [LocalizedText] instance with customizable labels and hints.
  ///
  /// All parameters are optional and default to English text if not provided.
  const LocalizedText({
    this.cardNumberLabel = _cardNumberLabelDefault,
    this.cardNumberHint = _cardNumberHintDefault,
    this.expiryDateLabel = _expiryDateLabelDefault,
    this.expiryDateHint = _expiryDateHintDefault,
    this.cvvLabel = _cvvLabelDefault,
    this.cvvHint = _cvvHintDefault,
    this.cardHolderLabel = _cardHolderLabelDefault,
    this.cardHolderHint = _cardHolderHintDefault,
  });

  static const String _cardNumberLabelDefault = 'Card number';
  static const String _cardNumberHintDefault = 'xxxx xxxx xxxx xxxx';
  static const String _expiryDateLabelDefault = 'Expiry Date';
  static const String _expiryDateHintDefault = 'MM/YY';
  static const String _cvvLabelDefault = 'CVV';
  static const String _cvvHintDefault = 'XXXX';
  static const String _cardHolderLabelDefault = 'Card Holder';
  static const String _cardHolderHintDefault = '';

  /// The label text displayed above the card number input field.
  ///
  /// Defaults to 'Card number'.
  final String cardNumberLabel;

  /// The hint text displayed inside the card number input field when empty.
  ///
  /// Defaults to 'xxxx xxxx xxxx xxxx'.
  final String cardNumberHint;

  /// The label text displayed above the expiry date input field.
  ///
  /// Defaults to 'Expiry Date'.
  final String expiryDateLabel;

  /// The hint text displayed inside the expiry date input field when empty.
  ///
  /// Defaults to 'MM/YY'.
  final String expiryDateHint;

  /// The label text displayed above the CVV input field.
  ///
  /// Defaults to 'CVV'.
  final String cvvLabel;

  /// The hint text displayed inside the CVV input field when empty.
  ///
  /// Defaults to 'XXXX'.
  final String cvvHint;

  /// The label text displayed above the card holder name input field.
  ///
  /// Defaults to 'Card Holder'.
  final String cardHolderLabel;

  /// The hint text displayed inside the card holder name input field when empty.
  ///
  /// Defaults to an empty string.
  final String cardHolderHint;
}
