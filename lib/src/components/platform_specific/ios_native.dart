import 'package:wallet_apps/index.dart';

class IOSPlatform{
  
  static int defaultBrightnessLvl;

  static const platform = const MethodChannel("daveat/brightness");

  static Future<dynamic> getBrightness() async {
    defaultBrightnessLvl = await platform.invokeMethod("getBrightnessLevel");
    return defaultBrightnessLvl;
  }

  static Future<void> setHighBrightness() async {
    try{
      await platform.invokeMethod("setBrightnessLevel");
    } on PlatformException catch (e){

    }
  }

  static Future<void> resetBrightness(int brightness) async {
    try{
      await platform.invokeMapMethod("setDefaultBrightness", (brightness/100).toDouble());
    } on PlatformException catch (e){

    }
  }

}