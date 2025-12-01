import 'dart:async';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../floating_animation/floating_event.dart';
import 'flutter_credit_card_platform_interface.dart';

/// Web implementation of [FlutterCreditCardPlatform].
///
/// This class provides the web platform implementation, which disables
/// gyroscope-based floating animation since web browsers don't provide
/// direct gyroscope access.
///
/// On web platforms, the floating animation falls back to mouse cursor
/// tracking via [CursorListener] instead of gyroscope data.
class FlutterCreditCardWeb extends FlutterCreditCardPlatform {
  /// Constructs a FlutterCreditCardWeb instance.
  FlutterCreditCardWeb();

  /// Registers this implementation as the web platform instance.
  ///
  /// Called automatically by Flutter's web plugin registration system.
  static void registerWith(Registrar registrar) {
    FlutterCreditCardPlatform.instance = FlutterCreditCardWeb();
  }

  /// Always returns `false` since web doesn't support gyroscope.
  @override
  bool get isGyroscopeAvailable => false;

  /// Always returns `null` since web doesn't support gyroscope.
  @override
  Stream<FloatingEvent>? get floatingStream => null;

  /// No-op on web platform.
  @override
  Future<void> initialize() async {}

  /// No-op on web platform.
  @override
  Future<void> initiateEvents() async {}

  /// No-op on web platform.
  @override
  Future<void> cancelEvents() async {}

  /// No-op on web platform.
  @override
  Future<void> dispose() async {}
}
