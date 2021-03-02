package com.wind.app.flutter;

import android.app.Application;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

/**
 * created by wind on 3/1/21:5:28 PM
 */
public class App extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        FlutterEngine flutterEngine=new FlutterEngine(this);
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );

        FlutterEngineCache.getInstance().put("engine_name",flutterEngine);
    }
}
