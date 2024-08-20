import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'deeplink_connect_method_channel.dart';

abstract class DeeplinkConnectPlatform extends PlatformInterface {
  /// Constructs a DeeplinkConnectPlatform.
  DeeplinkConnectPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeeplinkConnectPlatform _instance = MethodChannelDeeplinkConnect();

  /// The default instance of [DeeplinkConnectPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeeplinkConnect].
  static DeeplinkConnectPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeeplinkConnectPlatform] when
  /// they register themselves.
  static set instance(DeeplinkConnectPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getDeviceModel(){
     throw UnimplementedError('getDeviceModel() has not been implemented.');
  }

  Future<String?> sendUri(String uriString){
     throw UnimplementedError('send() has not been implemented.');
  }

  // Novo método para receber resposta do deep link
  Stream<String>? get onResponse {
    throw UnimplementedError('onDeepLinkResponse has not been implemented.');
  }

  void close(){
    throw UnimplementedError('close() has not been implemented.');
  }
}
