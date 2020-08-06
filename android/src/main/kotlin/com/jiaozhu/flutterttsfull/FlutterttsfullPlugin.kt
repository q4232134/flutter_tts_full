package com.jiaozhu.flutterttsfull

import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterttsfullPlugin */
public class FlutterttsfullPlugin : FlutterPlugin, MethodCallHandler, TTsUtil.TTsListener {
    companion object {
        lateinit var tTsUtil: TTsUtil
        val handler = Handler(Looper.getMainLooper())
        lateinit var channel: MethodChannel


        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutterttsfull")
            channel.setMethodCallHandler(FlutterttsfullPlugin())
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val temp = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutterttsfull")
        tTsUtil = TTsUtil(flutterPluginBinding.applicationContext)
        tTsUtil.listener = this
        channel = temp
        temp.setMethodCallHandler(FlutterttsfullPlugin());
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        when (call.method) {
            "release" -> {
                tTsUtil.release()
                result.success(null)
            }
            "proper" -> {
                tTsUtil.proper(call.argument("title"), call.argument("content")!!, call.argument("history"))
                result.success(null)
            }
            "start" -> {
                tTsUtil.isPlaying = true
                result.success(null)
            }
            "stop" -> {
                tTsUtil.isPlaying = false
                result.success(null)
            }
            "isPlaying" ->
                result.success(tTsUtil.isPlaying)
            else ->
                result.notImplemented()
        }
    }

    private fun invokeMethod(method: String, arguments: Any?) {
        handler.post { channel.invokeMethod(method, arguments) }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onCancel(tag: String?) {
        invokeMethod("onCancel", mapOf("tag" to tag))
    }

    override fun onNext(tag: String?) {
        invokeMethod("onNext", mapOf("tag" to tag))
    }

    override fun onPlaying(tag: String?, content: String?, index: Int) {
        invokeMethod("onPlaying", mapOf("tag" to tag, "content" to content, "index" to index))
    }

    override fun onPause(tag: String?) {
        invokeMethod("onPause", mapOf("tag" to tag))
    }

    override fun onStart(tag: String?) {
        invokeMethod("onStart", mapOf("tag" to tag))
    }


    override fun onFinish(tag: String?) {
        invokeMethod("onFinish", mapOf("tag" to tag))
    }

}
