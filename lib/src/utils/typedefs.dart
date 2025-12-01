import 'package:flutter/widgets.dart';

import '../floating_animation/floating_event.dart';
import '../models/credit_card_brand.dart';
import '../models/credit_card_model.dart';

/// Callback signature for credit card model changes.
///
/// Used by [CreditCardForm.onCreditCardModelChange] to notify when any
/// credit card field value changes.
///
/// The [CreditCardModel] parameter contains all current field values and
/// the CVV focus state.
typedef CCModelChangeCallback = void Function(CreditCardModel);

/// Callback signature for credit card brand changes.
///
/// Used by [CreditCardWidget.onCreditCardWidgetChange] to notify when the
/// detected card brand changes based on the card number.
///
/// The [CreditCardBrand] parameter contains the detected card type.
typedef CCBrandChangeCallback = void Function(CreditCardBrand);

/// Callback signature for form field validation.
///
/// Used by the validator parameters in [CreditCardForm] to customize
/// field validation logic.
///
/// Returns `null` if validation passes, or an error message string if
/// validation fails.
typedef ValidationCallback = String? Function(String?);

/// Callback signature for floating event transformation.
///
/// Used by [FloatAnimationBuilder] to convert [FloatingEvent] data into
/// a transformation matrix.
///
/// Returns a [Matrix4] representing the desired transformation based on
/// the input event.
typedef FloatEventCallback = Matrix4 Function(FloatingEvent? event);

/// Callback signature for deferred widget building.
///
/// Used by [FloatAnimationBuilder] to lazily build child widgets on
/// each stream event.
typedef WidgetCallback = Widget Function();
