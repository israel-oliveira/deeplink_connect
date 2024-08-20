package br.com.isrtec.deeplink_connect

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import br.com.isrtec.deeplink_connect.ResponseHandler

class DeeplinkActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
        finish() // Finaliza a Activity imediatamente após processar o deep link
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        intent?.let { handleIntent(it) }
    }

    private fun handleIntent(intent: Intent) {
        val uri: Uri? = intent.data
        uri?.let {
            // Passa o deep link para o ResponseHandler
            ResponseHandler.handleDeepLink(applicationContext, intent)
        }
    }
}