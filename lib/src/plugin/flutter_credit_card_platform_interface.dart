import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../floating_animation/floating_event.dart';
import 'flutter_credit_card_method_channel.dart';

/// The platform interface for the flutter_credit_card plugin.
///
/// This abstract class defines the interface for platform-specific
/// implementations of the gyroscope functionality used for the floating
/// card animation.
///
/// Platform implementations should extend this class and register themselves
/// as the [instance] to provide platform-specific gyroscope access.
///
/// The default implementation is [MethodChannelFlutterCreditCard], which
/// uses method channels to communicate with native platform code.
abstract class FlutterCreditCardPlatform extends PlatformInterface {
  /// Constructs a FlutterCreditCardPlatform.
  FlutterCreditCardPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCreditCardPlatform _instance = MethodChannelFlutterCreditCard();

  /// The current platform-specific implementation.
  ///
  /// Defaults to [MethodChannelFlutterCreditCard].
  static FlutterCreditCardPlatform get instance => _instance;

  /// Sets the platform-specific implementation.
  ///
  /// Platform plugins should call this in their `registerWith` method
  /// to provide their custom implementation.
  static set instance(FlutterCreditCardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Whether gyroscope sensor data is available on this device.
  ///
  /// Returns `false` by default. Platform implementations should override
  /// this to indicate actual gyroscope availability.
  bool get isGyroscopeAvailable => false;

  /// A stream of [FloatingEvent]s from the gyroscope sensor.
  ///
  /// Returns `null` if gyroscope is not available. When available, the stream
  /// emits rotation rate data that can be used for the floating animation.
  Stream<FloatingEvent>? get floatingStream => null;

  /// Initializes the platform plugin and checks for gyroscope availability.
  ///
  /// Must be called before accessing [isGyroscopeAvailable] or [floatingStream].
  /// Sets up method and event channels for native communication.
  Future<void> initialize() async => throw UnimplementedError();

  /// Starts receiving gyroscope data events.
  ///
  /// Called internally after [initialize] determines that gyroscope is
  /// available.
  Future<void> initiateEvents() async => throw UnimplementedError();

  /// Stops receiving gyroscope data events.
  ///
  /// Cancels the event stream to stop receiving sensor updates.
  Future<void> cancelEvents() async => throw UnimplementedError();

  /// Disposes of platform resources.
  ///
  /// Cancels event streams and cleans up native resources. Should be called
  /// when the credit card widget is disposed.
  Future<void> dispose() async => throw UnimplementedError();
}
