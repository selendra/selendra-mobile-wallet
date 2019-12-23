import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget getWalletBody(
  BuildContext context,
  // Map<String, dynamic> userData,
  String token,
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
              containerTitleAppBar("Receive Token")
            ],
          )
        ),
        Expanded(
          child: Center(
            child: Card(
              margin: EdgeInsets.all(0),
              child: Container(
                padding: EdgeInsets.only(top: 44, left: 32, right: 32, bottom: 32),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 29.52),
                    child: qrCodeGenerate(token),
                  ),
                  /* Wallet Text */
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 17.0),
                          child: Text("Click on address to copy", style: TextStyle(fontSize: 17.0, color: getHexaColor("#959CA7")),),
                        ),
                        InkWell(
                          child: Text(token, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: getHexaColor(greenColor)), textAlign: TextAlign.center,),
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: token));
                            snackBar('Copied');
                          },
                        )
                        // InkWell(
                        //   child: ,
                        //   onTap: () {
                        //     Clipboard.setData(ClipboardData(text: userData['wallet']));
                        //     snackBar('Copied');
                        //   },
                        // )
                      ],
                    ),
                  )
                ],
              ),
              ),
            ),
          )
          // userData == null ? loading()
          // : userData['wallet'] == null ? textNotification("You do not have a wallet! Please verify your account to get wallet.!", context)
          // : Center(
          //   child: Card(
          //     margin: EdgeInsets.all(0),
          //     child: Container(
          //       padding: EdgeInsets.only(top: 44, left: 32, right: 32, bottom: 32),
          //       child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         Container(
          //           margin: EdgeInsets.only(bottom: 29.52),
          //           child: qrCodeGenerate(token),
          //         ),
          //         /* Wallet Text */
          //         Container(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               Container(
          //                 margin: EdgeInsets.only(bottom: 17.0),
          //                 child: Text("Click on address to copy", style: TextStyle(fontSize: 17.0, color: getHexaColor("#959CA7")),),
          //               ),
          //               InkWell(
          //                 child: Text(token, style: TextStyle(fontSize: 17.0, color: getHexaColor(greenColor)), textAlign: TextAlign.center,),
          //                 onTap: () {
          //                   Clipboard.setData(ClipboardData(text: token));
          //                   snackBar('Copied');
          //                 },
          //               )
          //               // InkWell(
          //               //   child: ,
          //               //   onTap: () {
          //               //     Clipboard.setData(ClipboardData(text: userData['wallet']));
          //               //     snackBar('Copied');
          //               //   },
          //               // )
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //     ),
          //   ),
          // ),
        )
      ],
    )
  );
}