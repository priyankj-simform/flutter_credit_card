import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../models/custom_card_type_icon.dart';
import 'constants.dart';
import 'enumerations.dart';

/// Detects the credit card type based on the card number prefix.
///
/// This function uses predefined prefix patterns from [AppConstants.cardNumPatterns]
/// to identify the card issuer. The detection is based on industry-standard
/// BIN (Bank Identification Number) patterns.
///
/// Returns [CardType.otherBrand] if the card number is empty or doesn't
/// match any known pattern.
///
/// ## Example
///
/// ```dart
/// // Visa card (starts with 4)
/// detectCCType('4242424242424242');  // CardType.visa
///
/// // Mastercard (starts with 51-55 or 2221-2720)
/// detectCCType('5555555555554444');  // CardType.mastercard
///
/// // American Express (starts with 34 or 37)
/// detectCCType('378282246310005');   // CardType.americanExpress
///
/// // Unknown
/// detectCCType('1234567890123456');  // CardType.otherBrand
/// ```
CardType detectCCType(String cardNumber) {
  if (cardNumber.isEmpty) {
    return CardType.otherBrand;
  }

  // Remove any spaces
  cardNumber = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');

  final int firstDigit = int.parse(
    cardNumber.length <= 1 ? cardNumber : cardNumber.substring(0, 1),
  );

  if (!AppConstants.cardNumPatterns.containsKey(firstDigit)) {
    return CardType.otherBrand;
  }

  final Map<List<int?>, CardType> cardNumPatternSubMap =
      AppConstants.cardNumPatterns[firstDigit]!;

  final int ccPatternNum = int.parse(cardNumber);

  for (final List<int?> range in cardNumPatternSubMap.keys) {
    int subPatternNum = ccPatternNum;

    if (range.length != 2 || range.first == null) {
      continue;
    }

    final int start = range.first!;
    final int? end = range.last;

    // Adjust the cardNumber prefix as per the length of start prefix range.
    final int startLen = start.toString().length;
    if (startLen < cardNumber.length) {
      subPatternNum = int.parse(cardNumber.substring(0, startLen));
    }

    if ((end == null && subPatternNum == start) ||
        ((subPatternNum <= (end ?? -double.maxFinite)) &&
            subPatternNum >= start)) {
      return cardNumPatternSubMap[range]!;
    }
  }

  return CardType.otherBrand;
}

/// Returns the appropriate card type icon widget for the given [cardType].
///
/// This function first checks [customIcons] for a user-defined icon matching
/// the card type. If no custom icon is found, it returns the bundled asset
/// image for known card types, or an empty [SizedBox] for unknown types.
///
/// The returned widget is sized to [AppConstants.creditCardIconSize] (48x48).
///
/// ## Example
///
/// ```dart
/// Widget icon = getCardTypeImage(
///   cardType: CardType.visa,
///   customIcons: [],
/// );
/// ```
Widget getCardTypeImage({
  required List<CustomCardTypeIcon> customIcons,
  CardType? cardType,
}) {
  const Widget blankSpace =
      SizedBox.square(dimension: AppConstants.creditCardIconSize);

  if (cardType == null) {
    return blankSpace;
  }

  return customIcons.firstWhere(
    (CustomCardTypeIcon element) => element.cardType == cardType,
    orElse: () {
      final bool isKnownCardType =
          AppConstants.cardTypeIconAsset.containsKey(cardType);

      return CustomCardTypeIcon(
        cardType: isKnownCardType ? cardType : CardType.otherBrand,
        cardImage: isKnownCardType
            ? Image.asset(
                AppConstants.cardTypeIconAsset[cardType]!,
                height: AppConstants.creditCardIconSize,
                width: AppConstants.creditCardIconSize,
                package: AppConstants.packageName,
              )
            : blankSpace,
      );
    },
  ).cardImage;
}

/// A [TextInputFormatter] that converts all input text to uppercase.
///
/// This formatter is used by [CreditCardForm] when
/// [CreditCardForm.isCardHolderNameUpperCase] is enabled to automatically
/// capitalize the card holder name as the user types.
///
/// ## Example
///
/// ```dart
/// TextField(
///   inputFormatters: [UpperCaseTextFormatter()],
/// )
/// ```
class UpperCaseTextFormatter extends TextInputFormatter {
  /// Creates an uppercase text formatter.
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
