package com.example.radiobarbaros

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

// Added these three import lines
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.os.Bundle;

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        // Added this line
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE);
    }
}
