import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/platform_specific/ios_native.dart';

class GetWallet extends StatefulWidget{
  final String wallet;

  GetWallet(this.wallet);

  @override
  State<StatefulWidget> createState() {
    return GetWalletState();
  }
}

class GetWalletState extends State<GetWallet>{
  
  String _brightnessLevel = "Unkown brigtness level";

  final _globalKey = GlobalKey<ScaffoldState>();

  dynamic result;

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    _platformChecker();
    super.initState();
  }

  void _platformChecker(){
    if(Platform.isAndroid) _androidHighBright();
    else _iOSHighBright();
  }

  Future<void> _androidHighBright() async {
    try{
      await AndroidPlatform.getBrightness();
      await AndroidPlatform.getBrightnessMode();
      if (AndroidPlatform.defaultBrightnessLvl < 50){

        await AndroidPlatform.checkPermission().then((value) async {
          if (value == false){
            await Component.messagePermission(
              context: context,
              content: "Brightness is low that hard to scan ! Click setting and turn on to allow auto brightness mode",
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

  Future<void> _iOSHighBright() async {
    try{
      await IOSPlatform.getBrightness().then((value) async {
        if (value < 40){
          await IOSPlatform.setHighBrightness();
        }
      });
    } on PlatformException catch (e) {

    }
  }

  void popScreen() {
    Navigator.pop(context);
  }

  /* Trigger Snack Bar Function */
  void snackBar(String contents) {
    final snackbar = SnackBar(
      content: Text(contents),
    );
    _globalKey.currentState.showSnackBar(snackbar);
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(
        child: getWalletBody(context, widget.wallet, snackBar, popScreen)
      ),
    );
  }
}