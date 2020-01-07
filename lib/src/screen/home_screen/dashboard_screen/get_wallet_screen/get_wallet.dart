import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/get_wallet_screen/get_wallet_body.dart';
import 'package:flutter/material.dart';

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
      body: getWalletBody(context, widget.wallet, snackBar, popScreen),
    );
  }
}