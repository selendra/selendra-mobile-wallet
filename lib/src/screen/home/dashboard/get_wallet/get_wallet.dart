import 'package:wallet_apps/src/screen/home/dashboard/get_wallet/get_wallet_body.dart';
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
  
  final _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    super.initState();
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