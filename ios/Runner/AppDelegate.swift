import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let batteryChannel = FlutterMethodChannel( // Register Your Platform Specific
            name: "daveat/brightness",
            binaryMessenger: controller.binaryMessenger
        )
        
        batteryChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "getBrightnessLevel"){
                result(self.getBrightness())
            } else if (call.method == "setBrightnessLevel"){
                UIScreen.main.brightness = CGFloat(1.0)
                result("Increased brightness")
            } else if (call.method == "setDefaultBrightness"){
                let args = call.arguments as! Double
                self.setBrightness(brightness: args)
                result(args)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(
            application, didFinishLaunchingWithOptions: launchOptions
        )
    }
    
    func setBrightness(brightness: Double = 1.0) -> Void {
        UIScreen.main.brightness = CGFloat(brightness)
    }
    
    func getBrightness() -> Int {
        return Int(UIScreen.main.brightness*100)
    }
    
}
