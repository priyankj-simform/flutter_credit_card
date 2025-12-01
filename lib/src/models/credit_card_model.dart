/// A model class representing credit card data entered via [CreditCardForm].
///
/// This class contains all the information entered by the user in the credit
/// card form, including card number, expiry date, card holder name, CVV code,
/// and the current focus state of the CVV field.
///
/// The model is passed to the [CreditCardForm.onCreditCardModelChange] callback
/// whenever any field value changes, allowing the parent widget to update
/// the [CreditCardWidget] display accordingly.
///
/// ## Example
///
/// ```dart
/// CreditCardForm(
///   // ... other parameters
///   onCreditCardModelChange: (CreditCardModel model) {
///     setState(() {
///       cardNumber = model.cardNumber;
///       expiryDate = model.expiryDate;
///       cardHolderName = model.cardHolderName;
///       cvvCode = model.cvvCode;
///       showBackView = model.isCvvFocused;
///     });
///   },
/// )
/// ```
class CreditCardModel {
  /// Creates a credit card model with the provided values.
  ///
  /// All parameters are required to ensure complete card data representation.
  CreditCardModel(
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    this.isCvvFocused,
  );

  /// The credit/debit card number.
  ///
  /// This value is formatted with spaces (e.g., "4242 4242 4242 4242")
  /// based on the mask applied in the form.
  String cardNumber = '';

  /// The card expiry date in MM/YY format.
  ///
  /// Example: "12/25" for December 2025.
  String expiryDate = '';

  /// The name of the card holder.
  ///
  /// May be uppercase depending on [CreditCardForm.isCardHolderNameUpperCase].
  String cardHolderName = '';

  /// The CVV (Card Verification Value) code.
  ///
  /// This is typically a 3-digit code (4 digits for American Express).
  String cvvCode = '';

  /// Whether the CVV field currently has focus.
  ///
  /// This is used to determine whether to show the back of the card
  /// (where the CVV is located) in the [CreditCardWidget].
  bool isCvvFocused = false;
}
