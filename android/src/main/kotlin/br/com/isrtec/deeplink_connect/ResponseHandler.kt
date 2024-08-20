package br.com.isrtec.deeplink_connect

import android.content.Context
import android.content.Intent
import android.net.Uri
import io.flutter.plugin.common.MethodChannel

object ResponseHandler {

    private var methodChannel: MethodChannel? = null

    fun setMethodChannel(channel: MethodChannel) {
        methodChannel = channel
    }

    fun handleDeepLink(context: Context, intent: Intent) {
        val uri = intent.data
        if (uri != null) {
            // val response = buildString {
            //     uri.queryParameterNames.forEach { param ->
            //         append("$param: ${uri.getQueryParameter(param)}\n")
            //     }
            // }
             val uriString = uri.toString()
            // Envia a resposta para o Flutter
            methodChannel?.invokeMethod("onDeepLinkResponse", uriString)
        }
    }
}