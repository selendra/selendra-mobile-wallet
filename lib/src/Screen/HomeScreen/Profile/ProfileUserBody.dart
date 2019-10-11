import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
/* QR Code Generate */
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

Widget bodyWidget(
  BuildContext context,
  Map<String, dynamic> userData,
  Function snackBar, Function dialogBox,
  /* isHaveWallet By Default false */
  bool isHaveWallet
) {
  return Container(
    padding: EdgeInsets.only(top: 72.0, left: margin4, right: margin4, bottom: margin4),
    width: double.infinity,
    child: Column(
      children: <Widget>[
        /* User image */
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(convertHexaColor(highThenBackgroundColor)),
                border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
              ),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(top: 150.0),
              child: isHaveWallet == false ? Container() : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: Text('Scan me', style: TextStyle(fontSize: 18.0, color: Colors.white),)
                  ),
                  qrCodeGenerate(userData['wallet']),
                  /* Wallet Text */
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Text("Wallet", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                        ),
                        InkWell(
                          child: Text(userData['wallet'], style: TextStyle(color: Color(convertHexaColor(lightBlueSky))),),
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: userData['wallet']));
                            snackBar('Copied');
                          },
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
            /* Circular Avatar User */ 
            FractionalTranslation(
              translation: Offset(0.0, -0.40),
              child: Align(
                child: Column(
                  children: <Widget>[
                    /* User Avatar */
                    Container(
                      width: 130.0,
                      height: 130.0,
                      alignment: FractionalOffset(0.0, 0.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(convertHexaColor("#2FC8DE")),
                            Color(convertHexaColor("#93E788"))
                          ]
                        ),
                        border: Border.all(
                          color: Color(convertHexaColor(borderColor)),
                          width: 2.0
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('assets/avatar.png')
                            /* If User Profile Empty Or Null */ 
                            // userData == null ? AssetImage('assets/avatar.png') :
                            // userData['profile_img'] == "" ? AssetImage('assets/avatar.png') :
                            // userData['profile_image'] == null ? AssetImage('assets/avatar.png') : 
                            /* If User Have Profile Image */
                            // NetworkImage(userData['profile_img'])
                        )
                      ),
                    ),
                    /* User Full name */
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text(userData == null 
                        ? "Set Name" 
                        : "${userData['last_name'] == null ? 'Set' : userData['last_name']} ${userData['first_name'] == null ? 'Name' : userData['first_name']}",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(convertHexaColor(lightBlueSky))),
                      ),
                    ),
                  ],
                ),
                alignment: FractionalOffset(0.5, 0.0),
              ),
            )
          ],
        ),
        /* Import Wallet Button */
        isHaveWallet == false ? 
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(convertHexaColor("#363639")),
            border: Border.all(width: 1.0, color: Color(convertHexaColor("#2BB9CD"))),
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0, top: 50.0),
          child: FlatButton(
            textColor: Color(convertHexaColor("#2BB9CD")),
            splashColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Icon(Icons.save_alt,),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text('Import Wallet'),
                )
              ],
            ),
            onPressed: (){
            },
          ),
        )
         : Container(),
        /* Button Get Wallet */
        isHaveWallet == false ? 
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(convertHexaColor("#363639")),
            border: Border.all(width: 1.0, color: Color(convertHexaColor("#93E788"))),
          ),
          child: FlatButton(
            splashColor: Colors.white,
            focusColor: Colors.white,
            textColor: Color(convertHexaColor("#93E788")),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Icon(Icons.account_balance_wallet,),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text('Get Wallet'),
                )
              ],
            ),
            onPressed: () async {
              dialogBox(context);
            },
          ),
        )
        : Container()
      ],
    ),
  );
}
