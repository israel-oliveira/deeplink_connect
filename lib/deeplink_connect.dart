import 'deeplink_connect_platform_interface.dart';
export 'model/deeplink_payment.dart';

class DeeplinkConnect {
  Future<String?> getPlatformVersion() {
    return DeeplinkConnectPlatform.instance.getPlatformVersion();
  }

  Future<String?> getDeviceModel() {
    return DeeplinkConnectPlatform.instance.getDeviceModel();
  }

  Future<void> send(String uriString) {
    return DeeplinkConnectPlatform.instance.sendUri(uriString);
  }

  // Adiciona um getter para expor o stream de respostas de deep links
  Stream<String>? get onDeepLinkResponse {
    return DeeplinkConnectPlatform.instance.onResponse;
  }

  void close() {
    return DeeplinkConnectPlatform.instance.close();
  }
}
