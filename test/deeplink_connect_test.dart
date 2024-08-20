import 'package:flutter_test/flutter_test.dart';
import 'package:deeplink_connect/deeplink_connect.dart';
import 'package:deeplink_connect/deeplink_connect_platform_interface.dart';
import 'package:deeplink_connect/deeplink_connect_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeeplinkConnectPlatform
    with MockPlatformInterfaceMixin
    implements DeeplinkConnectPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  Future<String?> getDeviceModel() {
    // TODO: implement getDeviceModel
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement onResponse
  Stream<String>? get onResponse => throw UnimplementedError();
  
  @override
  Future<String?> sendUri(String uriString) {
    // TODO: implement sendUri
    throw UnimplementedError();
  }
  
  @override
  void close() {
    // TODO: implement close
  }
}

void main() {
  final DeeplinkConnectPlatform initialPlatform = DeeplinkConnectPlatform.instance;

  test('$MethodChannelDeeplinkConnect is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeeplinkConnect>());
  });

  test('getPlatformVersion', () async {
    DeeplinkConnect deeplinkConnectPlugin = DeeplinkConnect();
    MockDeeplinkConnectPlatform fakePlatform = MockDeeplinkConnectPlatform();
    DeeplinkConnectPlatform.instance = fakePlatform;

    expect(await deeplinkConnectPlugin.getPlatformVersion(), '42');
  });
}
