package com.wind.app.flutter

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.RuntimeException
import java.util.HashMap

/**
 * created by wind on 3/10/21:2:22 PM
 */
object MethodChannelImpl :MethodChannel.MethodCallHandler{
    val DEFAULT_CHANNEL_NAME="default_channel_name"
    private val METHOD_GET_HTTP_HEADERS="getHttpHeaders"

    private val channelMap= mutableMapOf<String,MethodChannel>()

    fun setEngine(flutterEngine: FlutterEngine, channel:String){
        var methodChannel=channelMap.get(channel)
        if (methodChannel==null){
            methodChannel=MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, channel)
            methodChannel.setMethodCallHandler(this)
            channelMap.put(channel,methodChannel)
        }else{
            throw RuntimeException("already exist ${channel} MethodChannel")
        }
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        try {
            doMethodCallSafety(call, result)
        }catch (e:Exception){
            result.error("500",e.message,null)
        }

    }

    private fun doMethodCallSafety(call: MethodCall, result: MethodChannel.Result) {
        var resultValue:Any?=null
        when(call.method){
            METHOD_GET_HTTP_HEADERS-> resultValue=getHttpHeaders()
        }
        result.success(resultValue)
    }


    private fun getHttpHeaders(): Map<String, Any> {
        val headers: MutableMap<String, Any> =
            HashMap()
        headers["token"] = "this is my token from android activity";
        return headers
    }
}