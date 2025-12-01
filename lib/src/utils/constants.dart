import 'dart:math';

import 'package:flutter/rendering.dart';

import 'asset_paths.dart';
import 'enumerations.dart';

/// Contains constant values used throughout the flutter_credit_card package.
///
/// This class provides static constants for:
/// - Package metadata (name, font family)
/// - Default text strings and masks
/// - UI dimensions and styling
/// - Animation timing constants
/// - Color values
/// - Card number prefix patterns for card type detection
///
/// These constants are used internally by the package and may be useful
/// for applications that need to match the package's default styling.
class AppConstants {
  const AppConstants._();

  /// The package name used for loading bundled assets.
  static const String packageName = 'flutter_credit_card';

  /// The font family used for card number display.
  static const String fontFamily = 'halter';

  /// Placeholder text representing 3 unknown digits (e.g., for CVV).
  static const String threeX = 'XXX';

  /// Placeholder text representing 4 unknown digits.
  static const String fourX = 'XXXX';

  /// Placeholder text representing a full 16-digit card number.
  static const String sixteenX = 'XXXX XXXX XXXX XXXX';

  /// Input mask pattern for card numbers.
  static const String cardNumberMask = '0000 0000 0000 0000';

  /// Input mask pattern for expiry dates.
  static const String expiryDateMask = '00/00';

  /// Input mask pattern for CVV codes (supports up to 4 digits for Amex).
  static const String cvvMask = '0000';

  /// Label text for CVV field.
  static const String cvv = 'CVV';

  /// Uppercase label text for card holder field (used on card display).
  static const String cardHolderCaps = 'CARD HOLDER';

  /// Title case label text for card holder field (used in form).
  static const String cardHolder = 'Card Holder';

  /// Label text for card number field.
  static const String cardNumber = 'Card Number';

  /// Label text for expiry date field.
  static const String expiryDate = 'Expiry Date';

  /// Short format expiry date placeholder.
  static const String expiryDateShort = 'MM/YY';

  /// "Valid Thru" label text displayed on card.
  static const String validThru = 'VALID\nTHRU';

  /// Default validation message for invalid CVV.
  static const String cvvValidationMessage = 'Please input a valid CVV';

  /// Default validation message for invalid date.
  static const String dateValidationMessage = 'Please input a valid date';

  /// Default validation message for invalid card number.
  static const String numberValidationMessage = 'Please input a valid number';

  /// Breakpoint width for web floating animation behavior.
  static const double floatWebBreakPoint = 650;

  /// Aspect ratio for credit card (height / width).
  static const double creditCardAspectRatio = 0.5714;

  /// Default padding around the credit card widget.
  static const double creditCardPadding = 16;

  /// Size of card type icon in logical pixels.
  static const double creditCardIconSize = 48;

  /// Border radius for the credit card corners.
  static const BorderRadius creditCardBorderRadius = BorderRadius.all(
    Radius.circular(10),
  );

  /// Minimum rest-back velocity for floating animation.
  static const double minRestBackVel = 0.01;

  /// Maximum rest-back velocity for floating animation.
  static const double maxRestBackVel = 0.05;

  /// Default rest-back velocity for floating animation.
  static const double defaultRestBackVel = 0.8;

  /// Duration representing 60 FPS frame rate.
  static const Duration fps60 = Duration(microseconds: 16666);

  /// Duration offset for 60 FPS timer intervals.
  static const Duration fps60Offset = Duration(microseconds: 16667);

  /// Default duration for flip animation.
  static const Duration defaultAnimDuration = Duration(milliseconds: 500);

  /// Default color for glare effect overlay.
  static const Color defaultGlareColor = Color(0xffFFFFFF);

  /// Default color for floating card shadow.
  static const Color floatingShadowColor = Color(0x4D000000);

  /// Default background color for credit card.
  static const Color defaultCardBgColor = Color(0xff1b447b);

  /// Default maximum rotation angle for floating animation.
  static const double defaultMaximumAngle = pi / 10;

  /// Minimum blur radius for floating shadow.
  static const double minBlurRadius = 10;

  /// Method channel name for gyroscope plugin communication.
  static const String gyroMethodChannelName = 'com.simform.flutter_credit_card';

  /// Event channel name for gyroscope data stream.
  static const String gyroEventChannelName =
      'com.simform.flutter_credit_card/gyroscope';

  /// Method name for checking gyroscope availability.
  static const String isGyroAvailableMethod = 'isGyroscopeAvailable';

  /// Method name for initiating gyroscope events.
  static const String initiateMethod = 'initiateEvents';

  /// Method name for canceling gyroscope events.
  static const String cancelMethod = 'cancelEvents';

  // TODO(aditya): Switch to records instead of list as key for the inner map. For ex (start: 655021, end: 655058).
  /// Credit card number prefix patterns for card type detection.
  ///
  /// The outer map key is the first digit of the card number, which helps
  /// narrow down the search space. The inner map keys are lists of two
  /// integers representing the start and end of a prefix range (inclusive),
  /// and the values are the corresponding [CardType].
  ///
  /// Based on industry-standard BIN (Bank Identification Number) patterns
  /// as of March 2019.
  ///
  /// Keys are sorted in descending order by the first digit of the start
  /// range for optimal matching.
  static const Map<int, Map<List<int?>, CardType>> cardNumPatterns =
      <int, Map<List<int?>, CardType>>{
    6: <List<int?>, CardType>{
      <int?>[655021, 655058]: CardType.elo,
      <int?>[655000, 655019]: CardType.elo,
      <int?>[6521, 6522]: CardType.rupay,
      <int?>[651652, 651679]: CardType.elo,
      <int?>[650901, 650978]: CardType.elo,
      <int?>[650720, 650727]: CardType.elo,
      <int?>[650700, 650718]: CardType.elo,
      <int?>[650541, 650598]: CardType.elo,
      <int?>[650485, 650538]: CardType.elo,
      <int?>[650405, 650439]: CardType.elo,
      <int?>[650035, 650051]: CardType.elo,
      <int?>[650031, 650033]: CardType.elo,
      <int?>[65, null]: CardType.discover,
      <int?>[644, 649]: CardType.discover,
      <int?>[636368, null]: CardType.elo,
      <int?>[636297, null]: CardType.elo,
      <int?>[627780, null]: CardType.elo,
      <int?>[622126, 622925]: CardType.discover,
      <int?>[62, null]: CardType.unionpay,
      <int?>[606282, null]: CardType.hipercard,
      <int?>[6011, null]: CardType.discover,
      <int?>[60, null]: CardType.rupay,
    },
    5: <List<int?>, CardType>{
      <int?>[51, 55]: CardType.mastercard,
      <int?>[509000, 509999]: CardType.elo,
      <int?>[506699, 506778]: CardType.elo,
      <int?>[504175, null]: CardType.elo,
    },
    4: <List<int?>, CardType>{
      <int?>[457631, 457632]: CardType.elo,
      <int?>[457393, null]: CardType.elo,
      <int?>[451416, null]: CardType.elo,
      <int?>[438935, null]: CardType.elo,
      <int?>[431274, null]: CardType.elo,
      <int?>[401178, 401179]: CardType.elo,
      <int?>[4, null]: CardType.visa,
    },
    3: <List<int?>, CardType>{
      <int?>[34, 37]: CardType.americanExpress,
    },
    2: <List<int?>, CardType>{
      <int?>[2720, null]: CardType.mastercard,
      <int?>[270, 271]: CardType.mastercard,
      <int?>[23, 26]: CardType.mastercard,
      <int?>[223, 229]: CardType.mastercard,
      <int?>[2221, 2229]: CardType.mastercard,
      <int?>[2200, 2204]: CardType.mir,
    },
  };

  /// Map of [CardType] to corresponding asset path for card type icons.
  ///
  /// Used by [getCardTypeImage] to display the appropriate card brand logo.
  static const Map<CardType, String> cardTypeIconAsset = <CardType, String>{
    CardType.visa: AssetPaths.visa,
    CardType.rupay: AssetPaths.rupay,
    CardType.americanExpress: AssetPaths.americanExpress,
    CardType.mastercard: AssetPaths.mastercard,
    CardType.unionpay: AssetPaths.unionpay,
    CardType.discover: AssetPaths.discover,
    CardType.elo: AssetPaths.elo,
    CardType.hipercard: AssetPaths.hipercard,
    CardType.mir: AssetPaths.mir,
  };
}
