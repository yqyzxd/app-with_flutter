package com.wind.app.flutter

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity : AppCompatActivity() {
    val CHANNEL = "com.wind/app_info"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        println("onCreate")
        setContentView(R.layout.activity_main)
        findViewById<Button>(R.id.btn).setOnClickListener {
            startActivity(
                    FlutterActivity
                            .withCachedEngine("engine_name")
                            .build(this)
            )
        }

        val flutterEngine= FlutterEngineCache.getInstance().get("engine_name")
        MethodChannelImpl.setEngine(flutterEngine!!,CHANNEL)



        val remainMemory=RuntimeUtil.getSystemRemainMemory()
        val appMemory=RuntimeUtil.getAppMemory()
        val processStatus=RuntimeUtil.getProcessStatus()

        val eventLog=RuntimeUtil.getEventLog()

        val cpuCount=RuntimeUtil.getCPUCount()
        println("cpuCount:$cpuCount")
    }

    override fun onResume() {
        super.onResume()
        println("onResume")
    }

    override fun onPause() {
        super.onPause()
        println("onPause")
    }

    override fun onStop() {
        super.onStop()
        println("onStop")
    }

}