import 'package:wallet_apps/index.dart';

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

  GlobalKey _keyQrShare = GlobalKey();

  dynamic result;

  GetWalletFunction _function = GetWalletFunction();

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    _function.platformChecker(context);
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(
        child: getWalletBody(context, _globalKey, _keyQrShare, widget.wallet, _function)
      ),
    );
  }
}