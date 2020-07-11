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

  double wallets = 0.0;

  dynamic result;

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    // _androidHighBright();
    _iOSHighBright();
    super.initState();
  }

  Future<void> _androidHighBright() async {
    try{
      await AndroidPlatform.getBrightness();
      await AndroidPlatform.getBrightnessMode();
      if (AndroidPlatform.defaultBrightnessLevel < 50){

        await AndroidPlatform.checkPermission().then((value) async {
          if (value == false){
            await message().then((value) async { // Check User Enabled Permission
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
      await IOSPlatform.getBrightness().then((value) {

        setState(() {
          wallets = value;
        });
      });
      await dialog(context, Text("${IOSPlatform.defaultBrightnessLvl}"), Text("Message"));
      if (IOSPlatform.defaultBrightnessLvl < 30){
        await IOSPlatform.setHighBrightness();
      }
    } on PlatformException catch (e) {

    }
  }

  Future message() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text("Message"),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text("Brightness is low that hard to scan ! Click setting and turn on to allow auto brightness mode", textAlign: TextAlign.center),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Setting'),
              onPressed: () async {

                await AndroidPlatform.writePermission();

                await AndroidPlatform.checkPermission().then((value) async {
                  if (value == true){
                    Navigator.pop(context, true);
                  } else {
                    Navigator.pop(context, false);
                  }
                });
              },
            ),
          ],
        );
      }
    );
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
        child: getWalletBody(context, widget.wallet, wallets, snackBar, popScreen)
      ),
    );
  }
}