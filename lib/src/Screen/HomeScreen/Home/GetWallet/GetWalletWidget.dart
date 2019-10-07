import 'package:Wallet_Apps/src/Graphql_Service/Query_Document.dart';
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Provider_General.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetWalletWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return GetWalletState();
  }
}

class GetWalletState extends State<GetWalletWidget>{

  double margin80 = 80.0;

  Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    fetchWallet();
  }

  /* Fetch Only User ID */
  void fetchWallet() async {
    userData = await fetchData("userStatusAndWallet");
    Future.delayed(Duration(seconds: 1), () {
      setState(() { });
    });
  }


  void popScreen() {
    Navigator.pop(context);
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: appBar('Get wallet', popScreen, Colors.white),
              ),
              userData == null ? Expanded(child: loading(),)
              : userData['wallet'] == null ? Expanded(child: textNotification("You do not have a wallet!Please verify your account to get wallet.!", context),)
              : Container(
                  padding: EdgeInsets.only(top: margin80),
                  margin: EdgeInsets.only(top: 72.0, left: margin4, right: margin4, bottom: margin4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(lightBlueSky))),
                    color: Color(convertHexaColor(highThenBackgroundColor)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: margin80),
                        child: qrCodeGenerate(userData['wallet']),
                      ),
                      /* Wallet Text */
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text("Wallet", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                            ),
                            Text(userData['wallet'], style: TextStyle(color: Color(convertHexaColor(lightBlueSky))),)
                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          )
        ],
      )
    );
  }
}