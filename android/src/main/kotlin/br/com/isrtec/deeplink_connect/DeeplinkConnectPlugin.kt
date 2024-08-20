package br.com.isrtec.deeplink_connect


import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** DeeplinkConnectPlugin */
class DeeplinkConnectPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "deeplink_connect")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    ResponseHandler.setMethodChannel(channel)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${Build.VERSION.RELEASE}")
      }
      "getDeviceModel" -> {
        result.success("${Build.MODEL}")
      }
      "send" -> {
        val uriString = call.argument<String>("uriString")
        if (uriString != null) {
          val intent = Intent(Intent.ACTION_VIEW).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            data = Uri.parse(uriString)
          }

          context.startActivity(intent)
          result.success(null)

        } else {
          result.error("INVALID_ARGUMENT", "URI string is null", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
