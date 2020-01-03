import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/get_wallet_screen/get_wallet_body.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:flutter/material.dart';

class GetWallet extends StatefulWidget{
  final String token;

  GetWallet(this.token);

  @override
  State<StatefulWidget> createState() {
    return GetWalletState();
  }
}

class GetWalletState extends State<GetWallet>{
  
  final _globalKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
  }

  /* Fetch Only User ID */
  void fetchWallet() async {
    userData = await fetchData("user_profile");
    print(userData);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });
  }


  void popScreen() {
    Navigator.pop(context);
  }

  /* Trigger Snack Bar Function */
  snackBar(String contents) {
    final snackbar = SnackBar(
      content: Text(contents),
    );
    _globalKey.currentState.showSnackBar(snackbar);
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: getWalletBody(context, widget.token, snackBar, popScreen),
    );
  }
}