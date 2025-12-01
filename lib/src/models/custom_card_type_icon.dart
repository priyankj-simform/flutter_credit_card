import 'package:flutter/widgets.dart';

import '../utils/enumerations.dart';

/// A model for providing custom card type icons.
///
/// This class allows you to override the default card type icons displayed
/// on the [CreditCardWidget] with custom widgets of your choice.
///
/// ## Example
///
/// ```dart
/// CreditCardWidget(
///   // ... other parameters
///   customCardTypeIcons: [
///     CustomCardTypeIcon(
///       cardType: CardType.visa,
///       cardImage: Image.asset(
///         'assets/custom_visa.png',
///         height: 48,
///         width: 48,
///       ),
///     ),
///     CustomCardTypeIcon(
///       cardType: CardType.mastercard,
///       cardImage: Image.asset(
///         'assets/custom_mastercard.png',
///         height: 48,
///         width: 48,
///       ),
///     ),
///   ],
/// )
/// ```
///
/// See also:
/// - [CardType] for the list of supported card types.
/// - [CreditCardWidget.customCardTypeIcons] for using custom icons.
class CustomCardTypeIcon {
  /// Creates a custom card type icon mapping.
  ///
  /// Both [cardType] and [cardImage] are required.
  CustomCardTypeIcon({
    required this.cardType,
    required this.cardImage,
  });

  /// The card type that this custom icon represents.
  ///
  /// When the detected card type matches this value, the [cardImage]
  /// widget will be displayed instead of the default icon.
  CardType cardType;

  /// The widget to display as the card type icon.
  ///
  /// This is typically an [Image] widget, but can be any widget.
  /// Recommended size is 48x48 logical pixels to match the default icons.
  Widget cardImage;
}
