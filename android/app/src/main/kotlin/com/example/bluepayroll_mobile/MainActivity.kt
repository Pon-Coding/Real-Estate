package com.blue.re

import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Base64
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException


class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter_communication_channel";

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE,
        );
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setupMethodChannel(flutterEngine)
    }

    private fun setupMethodChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "getRadioVersion" -> {
                    result.success(android.os.Build.getRadioVersion())
                }
                "getKeystoreInfo" -> {
                    try {
                        val info: PackageInfo = context.packageManager.getPackageInfo(
                        context.packageName,
                        PackageManager.GET_SIGNATURES)

                        for (signature in info.signatures) {
                            var md: MessageDigest
                            md = MessageDigest.getInstance("SHA1")
                            md.update(signature.toByteArray())
                            val hash: String = String(Base64.encode(md.digest(), Base64.NO_WRAP))
                            result.success(hash.toString())
                        }
                    } catch (e1: PackageManager.NameNotFoundException) {
                        result.success(e1.toString());
                    } catch (e: NoSuchAlgorithmException) {
                        result.success(e.toString());
                    } catch (e: Exception) {
                        result.success(e.toString());
                    }
                }
                else -> result.notImplemented()
            }

        }
    }
}
