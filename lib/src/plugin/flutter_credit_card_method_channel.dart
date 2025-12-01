import 'dart:io';

import 'package:flutter/services.dart';

import '../floating_animation/floating_event.dart';
import '../utils/constants.dart';
import '../utils/enumerations.dart';
import 'flutter_credit_card_platform_interface.dart';

/// Method channel implementation of [FlutterCreditCardPlatform].
///
/// This class provides the default platform implementation using Flutter's
/// method channel and event channel mechanisms to communicate with native
/// Android and iOS code for gyroscope access.
///
/// The gyroscope data is used to create a floating animation effect on the
/// credit card widget, making it tilt based on device movement.
class MethodChannelFlutterCreditCard extends FlutterCreditCardPlatform {
  /// Event channel for receiving gyroscope data stream.
  static EventChannel? _gyroscopeEventChannel;

  /// Method channel for platform communication.
  static MethodChannel? _methodChannel;

  /// Cached stream of gyroscope events.
  static Stream<FloatingEvent>? _gyroscopeStream;

  /// Whether gyroscope is available on this device.
  static bool _isGyroscopeAvailable = false;

  @override
  bool get isGyroscopeAvailable => _isGyroscopeAvailable;

  @override
  Stream<FloatingEvent>? get floatingStream {
    try {
      _gyroscopeStream ??= _gyroscopeEventChannel
          ?.receiveBroadcastStream()
          .map<FloatingEvent>((dynamic event) {
        final List<double> list = event.cast<double>();
        return FloatingEvent(
          type: FloatingType.gyroscope,
          x: list.first,
          y: list[1],
          z: list[2],
        );
      });
      return _gyroscopeStream as Stream<FloatingEvent>;
    } catch (e) {
      // If a PlatformException is thrown, the plugin is not available on the
      // device.
      _isGyroscopeAvailable = false;
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    _methodChannel ??= const MethodChannel(AppConstants.gyroMethodChannelName);
    _gyroscopeEventChannel ??= const EventChannel(
      AppConstants.gyroEventChannelName,
    );

    if (Platform.isIOS || Platform.isAndroid) {
      _isGyroscopeAvailable = await _methodChannel!.invokeMethod<dynamic>(
            AppConstants.isGyroAvailableMethod,
          ) ??
          false;
    } else {
      // Other platforms should not use the gyroscope events.
      _isGyroscopeAvailable = false;
    }
    // We will only initialize event if gyroScope is available.
    if (_isGyroscopeAvailable) {
      await initiateEvents();
    }
  }

  @override
  Future<void> initiateEvents() async =>
      _methodChannel?.invokeMethod<dynamic>(AppConstants.initiateMethod);

  @override
  Future<void> cancelEvents() async {
    _gyroscopeStream = null;
    return _methodChannel?.invokeMethod<dynamic>(AppConstants.cancelMethod);
  }

  @override
  Future<void> dispose() async {
    if (_isGyroscopeAvailable) {
      await cancelEvents();
    }
    _isGyroscopeAvailable = false;
    _gyroscopeEventChannel = null;

    _methodChannel = null;
  }
}
