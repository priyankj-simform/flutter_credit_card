import 'package:flutter/widgets.dart';

/// A [TextEditingController] that automatically applies a mask to input text.
///
/// This controller formats user input according to a specified mask pattern,
/// useful for formatting credit card numbers, dates, phone numbers, and other
/// structured text inputs.
///
/// ## Mask Characters
///
/// The default translator interprets the following mask characters:
/// - `0`: Any digit (0-9)
/// - `A`: Any letter (a-z, A-Z)
/// - `@`: Any alphanumeric character
/// - `*`: Any character
///
/// All other characters in the mask are treated as literal characters and are
/// inserted automatically.
///
/// ## Example
///
/// ```dart
/// // Credit card number mask
/// final controller = MaskedTextController(
///   mask: '0000 0000 0000 0000',
/// );
///
/// // Expiry date mask
/// final expiryController = MaskedTextController(
///   mask: '00/00',
/// );
/// ```
///
/// ## Custom Translator
///
/// You can provide a custom translator map to define your own mask characters:
///
/// ```dart
/// final controller = MaskedTextController(
///   mask: 'AAA-0000',
///   translator: {
///     'A': RegExp(r'[A-Z]'),
///     '0': RegExp(r'[0-9]'),
///   },
/// );
/// ```
class MaskedTextController extends TextEditingController {
  /// Creates a masked text controller.
  ///
  /// The [mask] parameter is required and defines the format pattern.
  ///
  /// The optional [translator] parameter allows custom mask character
  /// definitions. If not provided, the default translator is used.
  MaskedTextController({
    required this.mask,
    super.text,
    Map<String, RegExp>? translator,
  }) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      final String previous = _lastUpdatedText;
      if (beforeChange(previous, text)) {
        updateText(text);
        afterChange(previous, text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(text);
  }

  /// The mask pattern used to format input text.
  ///
  /// Use mask characters (`0`, `A`, `@`, `*`) to define input positions,
  /// and any other characters as literal separators.
  String mask;

  /// A map of mask characters to their corresponding regular expressions.
  ///
  /// Each key is a single character used in the mask, and the value is a
  /// [RegExp] that defines what input characters are valid for that position.
  late Map<String, RegExp> translator;

  /// Callback invoked after the text value changes.
  ///
  /// Receives the previous and new text values as parameters.
  Function afterChange = (String previous, String next) {};

  /// Callback invoked before the text value changes.
  ///
  /// Receives the previous and new text values as parameters.
  /// Return `true` to allow the change, or `false` to revert to the previous
  /// value.
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  /// Updates the text field with the masked version of the given [text].
  ///
  /// If [text] is empty, the field is cleared.
  void updateText(String text) {
    if (text.isNotEmpty) {
      this.text = _applyMask(mask, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  /// Updates the mask pattern and reformats the current text.
  ///
  /// If [moveCursorToEnd] is true (the default), the cursor is moved to the
  /// end of the text after updating.
  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  /// Moves the text cursor to the end of the current text.
  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  /// Returns the default translator map for mask characters.
  ///
  /// Default translations:
  /// - `A`: Letters only
  /// - `0`: Digits only
  /// - `@`: Alphanumeric characters
  /// - `*`: Any character
  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String? mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask!.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator.containsKey(maskChar)) {
        if (translator[maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}
