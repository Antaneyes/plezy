import 'dart:io';
import 'package:flutter/services.dart';

/// Service to intercept hardware volume button presses on Android.
///
/// When enabled, volume button presses are sent to Flutter instead of
/// controlling system volume. This is useful for video players where
/// we want to control in-app volume rather than system volume.
class VolumeButtonService {
  static const _channel = MethodChannel('app.plezy/volume');

  static VoidCallback? onVolumeUp;
  static VoidCallback? onVolumeDown;
  static bool _initialized = false;
  static bool _enabled = false;

  /// Initialize the service. Call this once at app startup.
  static void init() {
    if (_initialized || !Platform.isAndroid) return;
    _initialized = true;

    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'volumeUp':
          onVolumeUp?.call();
          break;
        case 'volumeDown':
          onVolumeDown?.call();
          break;
      }
    });
  }

  /// Enable or disable volume button interception.
  ///
  /// When enabled, hardware volume buttons will trigger [onVolumeUp] and
  /// [onVolumeDown] callbacks instead of adjusting system volume.
  static Future<void> setInterceptionEnabled(bool enabled) async {
    if (!Platform.isAndroid) return;

    _enabled = enabled;
    await _channel.invokeMethod('setInterceptionEnabled', {'enabled': enabled});
  }

  /// Whether volume button interception is currently enabled.
  static bool get isEnabled => _enabled;
}
