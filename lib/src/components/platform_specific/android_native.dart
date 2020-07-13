import 'package:wallet_apps/index.dart';

class AndroidPlatform {

  static int defaultBrightnessLevel; static dynamic defaultBrightnessMode;


  static const platform = const MethodChannel("daveat/brightness");

  static Future<void> getBrightness() async {
    defaultBrightnessLevel = await platform.invokeMethod("getBrightnessLevel");
  }

  static Future<void> getBrightnessMode() async {
    defaultBrightnessMode = await platform.invokeMethod("getBrightnessMode");
  }

  static Future<void> increaseBrightness() async {
    try{
      if (defaultBrightnessLevel < 50){
        if (defaultBrightnessMode == "1"){
          await platform.invokeMethod("turnOffMode");
        }
        await platform.invokeMethod("increaseBrightness");
      }
    } on PlatformException catch (e){

    }
  }

  static Future<void> resetBrightness() async {
    try{
      
      var currentLevel = await platform.invokeMethod("getBrightnessLevel");
      var currentMode = await platform.invokeMethod("getBrightnessMode");

      if (currentLevel != defaultBrightnessLevel) { // Check Default Brightness Level Have Changed
        await platform.invokeMethod("setDefaultBrightness", <String, dynamic>{"value": defaultBrightnessLevel});
        if (currentMode != defaultBrightnessMode){  // Check Default Mode Have Changed
          if (defaultBrightnessMode == "1") await platform.invokeMethod("turnOnMode");
          else await platform.invokeMethod("turnOffMode");
        }
      }
    } on PlatformException catch (e){
      
    }

  }

  static Future<bool> checkPermission() async {
    return await AndroidPlatform.platform.invokeMethod("getPermission");
  }

  static Future writePermission() async {
    try{
      return await AndroidPlatform.platform.invokeMethod("writePermission");
    } on PlatformException catch (e) {

    }
  }

}