/// Utility class containing validation functions for credit card form fields.
///
/// These validators are used by [CreditCardForm] to validate user input.
/// Each validator returns `null` if validation passes, or an error message
/// if validation fails.
///
/// Custom validators can be provided to [CreditCardForm] to override
/// these default implementations.
class Validators {
  const Validators._();

  /// Validates a credit card number.
  ///
  /// A valid card number must be at least 16 characters including spaces
  /// (13 digits + 3 spaces in "XXXX XXXX XXXX XXXX" format).
  ///
  /// Returns [errorMsg] if the value is empty or too short, otherwise `null`.
  ///
  /// Note: This is a basic length check and does not perform Luhn algorithm
  /// validation.
  static String? cardNumberValidator(String? value, String errorMsg) {
    // Validate less than 13 digits + 3 white spaces
    return (value?.isEmpty ?? true) || (value?.length ?? 16) < 16
        ? errorMsg
        : null;
  }

  /// Validates a credit card expiry date.
  ///
  /// The date must be in MM/YY format and must not be in the past.
  /// The month must be between 01 and 12.
  ///
  /// Returns [errorMsg] if:
  /// - The value is empty
  /// - The date format is invalid
  /// - The card has expired (past the last day of the expiry month)
  /// - The month is invalid (0 or greater than 12)
  ///
  /// Returns `null` if validation passes.
  static String? expiryDateValidator(String? value, String errorMsg) {
    if (value?.isEmpty ?? true) {
      return errorMsg;
    }

    final DateTime now = DateTime.now();
    final List<String> date = value!.split(RegExp(r'/'));

    final int month = int.parse(date.first);
    final int year = int.parse('20${date.last}');

    final int lastDayOfMonth = month < 12
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;

    final DateTime cardDate =
        DateTime(year, month, lastDayOfMonth, 23, 59, 59, 999);

    if (cardDate.isBefore(now) || month > 12 || month == 0) {
      return errorMsg;
    }

    return null;
  }

  /// Validates a CVV (Card Verification Value) code.
  ///
  /// A valid CVV must be at least 3 digits (4 for American Express).
  ///
  /// Returns [errorMsg] if the value is empty or has fewer than 3 characters,
  /// otherwise `null`.
  static String? cvvValidator(String? value, String errorMsg) {
    return (value?.isEmpty ?? true) || ((value?.length ?? 3) < 3)
        ? errorMsg
        : null;
  }
}
