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

  GlobalKey<ScaffoldState> _globalKey;

  GlobalKey _keyQrShare = GlobalKey();

  dynamic result;

  GetWalletMethod _method = GetWalletMethod();

  @override
  void initState() {
    _globalKey = GlobalKey<ScaffoldState>();
    AppServices.noInternetConnection(_globalKey);
    _method.platformChecker(context);
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: GetWalletBody(
          keyQrShare: _keyQrShare,
          globalKey: _globalKey,
          wallet: widget.wallet,
          method: _method,
        )
      ),
    );
  }
}