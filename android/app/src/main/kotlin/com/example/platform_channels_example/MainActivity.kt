package com.example.platform_channels_example
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.os.Bundle
import java.util.Timer
import java.util.TimerTask
import android.content.Context

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

class MainActivity: FlutterActivity() {

    val timer = Timer()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Method Channel for Increment and Decrement counter values
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "Calculator").setMethodCallHandler { call, result ->
            var counter: Int? = call.argument<Int>("count")
            when (call.method) {
                "random" -> {
//                    result.success(Random(System.nanoTime()).nextInt(0, 100))
                }

                "incrementCounter", "decrementCounter","getBatteryLevel" -> {
                    if (counter == null) {
                        result.error("INVALID ARGUMENT", "Invalid Argument", null)
                    } else {
                        if (call.method == "incrementCounter") {
                            result.success(counter + 1)
                        }
                        else {
                            result.success(counter - 1)
                        }
                    }
                }


                else -> {
                    result.notImplemented()
                }
            }
        }

        // Set up the event channel
        EventChannel(flutterEngine!!.dartExecutor.binaryMessenger, "eventChannelTimer").setStreamHandler(
                object : EventChannel.StreamHandler {
                    private var counter = 0

                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        events?.success(counter)

                        timer?.scheduleAtFixedRate(object : TimerTask() {
                            override fun run() {
                                counter++
                                runOnUiThread {
                                    events?.success(counter)
                                }
                            }
                        }, 1000, 1000)
                    }

                    override fun onCancel(arguments: Any?) {
                        timer?.cancel()
                    }
                }
        )

        // Battery Percentage
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "BatteryCount").setMethodCallHandler { call, result ->

            if(call.method == "Battery"){
                val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                val batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                result.success(batteryLevel)
            }

        }


    }
    override fun onDestroy() {
        super.onDestroy()
        timer?.cancel()
    }


}
