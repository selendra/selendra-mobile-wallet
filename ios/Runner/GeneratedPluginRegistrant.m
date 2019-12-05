//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <barcode_scan/BarcodeScanPlugin.h>
#import <connectivity/ConnectivityPlugin.h>
#import <flutter_image_compress/FlutterImageCompressPlugin.h>
#import <flutter_webview_plugin/FlutterWebviewPlugin.h>
#import <image_cropper/ImageCropperPlugin.h>
#import <image_picker/ImagePickerPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BarcodeScanPlugin registerWithRegistrar:[registry registrarForPlugin:@"BarcodeScanPlugin"]];
  [FLTConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTConnectivityPlugin"]];
  [FlutterImageCompressPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterImageCompressPlugin"]];
  [FlutterWebviewPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterWebviewPlugin"]];
  [FLTImageCropperPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImageCropperPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
