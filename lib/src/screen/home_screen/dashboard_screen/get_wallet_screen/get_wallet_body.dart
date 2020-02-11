import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget getWalletBody(
  BuildContext context,
  // Map<String, dynamic> userData,
  String _wallet,
  Function snackBar, Function popScreen
){
  return scaffoldBGDecoration(
    16, 16, 16, 0,
    color1, color2,
    Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Receive Token", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        _wallet == null 
        ? Expanded(child: Center(child: Text("No Wallet", style: TextStyle(fontSize: 18.0),)),) 
        : Expanded(
          child: Center(
            child:  Card(
              margin: EdgeInsets.all(0),
              child: Container(
                padding: EdgeInsets.only(top: 44, left: 32, right: 32, bottom: 32),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container( /* Generate QR Code */
                    margin: EdgeInsets.only(bottom: 29.52),
                    child: qrCodeGenerate(_wallet, "yinkok_qr.png"),
                    // "zee_for_qr.png"
                  ),
                  Container( /* Wallet Text */
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 17.0),
                          child: Text("Click on address to copy", style: TextStyle(fontSize: 17.0, color: getHexaColor("#959CA7")),),
                        ),
                        InkWell(
                          child: Text(_wallet, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: getHexaColor(greenColor)), textAlign: TextAlign.center,),
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: _wallet)); /* Copy Text */
                            snackBar('Copied');
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              ),
            ),
          )
        )
      ],
    )
  );
}