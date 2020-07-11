import 'package:wallet_apps/index.dart';

class IOSPlatform{
  
  static double defaultBrightnessLvl;

  static const platform = const MethodChannel("daveat/brightness");

  static Future<double> getBrightness() async {
    return platform.invokeMethod("getBrightnessLevel");
  }

  static Future<void> setHighBrightness() async {
    try{
      if (defaultBrightnessLvl < 30){
        await platform.invokeMethod("increaseBrightness");
      }
    } on PlatformException catch (e){

    }
  }

  static Future<void> resetBrightness(double brightness) async {
    try{
      await platform.invokeMapMethod("setDefaultBrightness", (brightness/100).toDouble());
    } on PlatformException catch (e){

    }
  }

}