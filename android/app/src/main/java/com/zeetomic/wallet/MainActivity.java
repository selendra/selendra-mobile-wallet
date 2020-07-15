package com.zeetomic.wallet;

import android.os.Build;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.app.FlutterFragmentActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.Intent;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.provider.Settings;
import androidx.annotation.NonNull;

public class MainActivity extends FlutterFragmentActivity {

  private  static final String CHANNEL = "daveat/brightness";

  @Override
  protected void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState);
    
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(

      new MethodChannel.MethodCallHandler() {

        Object defaultMode = getBrightnessMode();

        @Override
        public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

          Object brightnessLevel;

          Object brightnessMode;

          if(call.method.equals("writePermission")){
            allowWritePermission();
            result.success(canWrite());
          } else if (call.method.equals("getPermission")){
            result.success(canWrite());
          }

          if (call.method.equals("getBrightnessMode")){
            result.success(getBrightnessMode());
          } else if (call.method.equals("getBrightnessLevel")){
            int value = getBrightnessLevel();
            result.success(value);
          }

          if (call.method.equals("turnOnMode")){
            result.success(getBrightnessMode());
          }

          if(canWrite()){ // If Enable Permission
              if (call.method.equals("turnOffMode")){
              setModeBrightness("0"); // Turn Off Auto Brightness Moder
              result.success("Turn off");
            } else if (call.method.equals("turnOnMode")){
              setModeBrightness("1");
            } else if(call.method.equals("increaseBrightness")){
              setBrightnessLevel(255);
              result.success("increased mode");
            } else if (call.method.equals("setDefaultBrightness")){
              int defaultLevel = call.argument("value");
              setBrightnessLevel(defaultLevel);
              result.success(defaultLevel);
            }
          }
//                else {
//                  result.notImplemented();
//                }
        }
      }
    );

  }

  boolean canWrite(){
    if(Build.VERSION.SDK_INT >= VERSION_CODES.M){
      return Settings.System.canWrite(this);
    } else {
      return true;
    }
  }

  void allowWritePermission(){
    if(VERSION.SDK_INT >= VERSION_CODES.M){
      Intent intent = new Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS);
      startActivity(intent);
    }
  }

  void setModeBrightness(String mode){
    Settings.System.putString(
      this.getContentResolver(),
      Settings.System.SCREEN_BRIGHTNESS_MODE,
      mode
    );
  }

  void setBrightnessLevel(int level){
    Settings.System.putInt(
      this.getContentResolver(),
      Settings.System.SCREEN_BRIGHTNESS,
      level
    );
  }

  String getBrightnessMode(){
    return Settings.System.getString(
      this.getContentResolver(),
      Settings.System.SCREEN_BRIGHTNESS_MODE
    );
  }

  int getBrightnessLevel(){
    return Settings.System.getInt(
      this.getContentResolver(),
      Settings.System.SCREEN_BRIGHTNESS,
      0
    );
  }
}
