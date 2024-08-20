import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'deeplink_connect_platform_interface.dart';

/// An implementation of [DeeplinkConnectPlatform] that uses method channels.
class MethodChannelDeeplinkConnect extends DeeplinkConnectPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('deeplink_connect');

  final _deepLinkResponseStreamController = StreamController<String>.broadcast();

  MethodChannelDeeplinkConnect() {
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

    @override
  Future<String?> getDeviceModel() async {
    final model = await methodChannel.invokeMethod<String>('getDeviceModel');
    return model;
  }

  @override
  Future<String?> sendUri(String uriString) async {
    final model = await methodChannel.invokeMethod<String>('send', {"uriString": uriString});
    return model;
  }

   @override
  Stream<String>? get onResponse => _deepLinkResponseStreamController.stream;

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onDeepLinkResponse') {
      final response = call.arguments as String;
      _deepLinkResponseStreamController.add(response);
    }
  }

@override
  void close() {
    _deepLinkResponseStreamController.close();
  }
}
