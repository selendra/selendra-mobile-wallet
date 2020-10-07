import 'package:wallet_apps/index.dart';
import 'dart:ui';

class GetWalletMethod {

  void platformChecker(BuildContext context){
    if(Platform.isAndroid) androidHighBright(context);
    else iOSHighBright();
  }

  Future<void> androidHighBright(BuildContext context) async {
    try{
      await AndroidPlatform.getBrightness();
      await AndroidPlatform.getBrightnessMode();
      if (AndroidPlatform.defaultBrightnessLvl < 50){

        await AndroidPlatform.checkPermission().then((value) async {
          if (value == false){
            await Component.messagePermission(
              context: context,
              content: "Brightness is low that hard to scan! Click setting and turn on to allow auto-brightness mode",
              method: () async {
                await AndroidPlatform.writePermission();

                await AndroidPlatform.checkPermission().then((value) async {
                  if (value == true){
                    Navigator.pop(context, true);
                  } else {
                    Navigator.pop(context, false);
                  }
                });
              }
            ).then((value) async { // Check User Enabled Permission
              if (value == true) {
                await AndroidPlatform.increaseBrightness();
              }
            });
          } else {
            await AndroidPlatform.increaseBrightness();
          }
        });
      }
    } on AndroidPlatform catch (e) {
      
    }
  }

  Future<void> iOSHighBright() async {
    try{
      await IOSPlatform.getBrightness().then((value) async {
        if (value < 40){
          await IOSPlatform.setHighBrightness();
        }
      });
    } on PlatformException catch (e) {

    }
  }

  void qrShare(GlobalKey globalKey, String _wallet) async {
    try{
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 5.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File("${tempDir.path}/selendra.png").create();
      await file.writeAsBytes(pngBytes);
      ShareExtend.share(
        file.path, 
        "image",
        subject: _wallet,
      );
      // Share.file(title, name, bytes, mimeType)
      // Share.file(title, name, bytes, mimeType)
      // multi("Zeetomic QR", "image", pngBytes, "My image");
      // Share.share(text)
    } catch (e) {
    }
  }

  void popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  /* Trigger Snack Bar Function */
  void snackBar(String contents, GlobalKey<ScaffoldState> _globalKey) {
    final snackbar = SnackBar(
      content: Text(contents),
    );
    _globalKey.currentState.showSnackBar(snackbar);
  }
}