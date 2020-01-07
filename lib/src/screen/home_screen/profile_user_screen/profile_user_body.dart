import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
/* QR Code Generate */
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/add_asset_screen/add_asset.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_pin_screen/change_pin.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/my_activity_screen/my_activity.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/set_pin_code_dialog_screen/set_pin_code_dialog.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/transaction_history_screen.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';
import 'package:wallet_apps/src/screen/main_screen/welcome_to_zees_screen/welcome_to_zees.dart';
import 'package:wallet_apps/src/service/services.dart';

Widget profileUserBodyWidget(
  bool isHaveWallet /* isHaveWallet By Default false */,
  BuildContext context,
  Map<String, dynamic> userData,
  ModelSignUp _modelSignUp,
  Function snackBar, Function dialogBox, Function popScreen
) {

  List<Map<String, dynamic>> listSettings = [
    {
      "icon": Icons.sort, 
      "title": "Edit Profile",
    },
    {
      "icon": Icons.query_builder, 
      "title": "Transaction History",
    },
    {
      "icon": Icons.query_builder, 
      "title": "Activity",
    },
    {
      "icon": Icons.account_balance_wallet, 
      "title": "Get Wallet",
    },
    {
      "icon": Icons.lock, 
      "title": "Change PIN",
    },
    {
      "icon": Icons.add, 
      "title": "Add Assets",
    },
    {
      "icon": Icons.exit_to_app, 
      "title": "Sign Out",
    }
  ];

  return Container(
    margin: EdgeInsets.only(left: 19, right: 19, bottom: size4),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /* User image */  
        Container(
          color: getHexaColor("#222834"),
          padding: EdgeInsets.all(20.25),
          child: 
          // isHaveWallet == false ? Container() : 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container( /* Close Button */
                margin: EdgeInsets.only(bottom: 26.75),
                // height: 30.0,
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.all(10.0),
                  color: getHexaColor("#97AAC3"),
                  iconSize: 30.0,
                  alignment: Alignment.topRight,
                  icon: Icon(Icons.close),
                  onPressed: popScreen,
                ),
              ),
              Container( /* Avatar Image */
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  border: Border.all(width: 1, color: getHexaColor(greenColor))
                ),
                child: Image.asset("assets/avatar.png", width: 100, height: 100,)
              ),
              Container( /* User Name */
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text("Username", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row( /* User Status */
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: Icon(Icons.check_circle, color: getHexaColor(greenColor),),
                    ),
                    Text("Verified", style: TextStyle(color: getHexaColor(greenColor)),)
                  ],
                ),
              ),
            ],
          )
        ),
        ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: listSettings.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 19.0, right: 19.0),
              decoration: BoxDecoration(
                color: getHexaColor("#222834"),
                border: Border(top: BorderSide(width: 1, color: Colors.white.withOpacity(0.1)))
              ),
              child: ListTile(
                onTap: () async {
                  switch (index) {
                    case 0 : {
                      Navigator.pop(context, '');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo(_modelSignUp)));
                      break;
                    }
                    case 1 : {
                      Navigator.pop(context, '');
                      blurBackgroundDecoration(context, TransactionHistoryWidget()); break;
                    }
                    case 2 : {
                      Navigator.pop(context, '');
                      blurBackgroundDecoration(context, MyActivity());
                      break;
                    }
                    case 3 : {
                      await dialogBox(context); break;
                    }
                    case 4 : {
                      Navigator.pop(context, '');
                      blurBackgroundDecoration(context, ChangePIN()); break;
                    }
                    case 5: {
                      Navigator.pop(context, '');
                      blurBackgroundDecoration(context, AddAsset()); break;
                    }
                    case 6:  {
                      dialogLoading(context);
                      clearStorage();
                      await Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context); /* Close Dialog Loading */
                      });
                      Navigator.pop(context, ''); /* Close Profile Screen */
                      await Future.delayed(Duration(milliseconds: 100), () {
                        Navigator.pushReplacementNamed(context, '/');
                      });
                    }
                  }
                },
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                  padding: EdgeInsets.all(0),
                  decoration: index == 0 ? BoxDecoration(
                    color: getHexaColor("#EFF0F2"),
                    borderRadius: BorderRadius.circular(2.0)
                  ) : null,
                  child: Icon(listSettings[index]['icon'], color: getHexaColor(index == 0 ? "#000000" : "#EFF0F2"),),
                ),
                title: Text(listSettings[index]["title"], style: TextStyle(fontWeight: FontWeight.bold, color: getHexaColor("#EFF0F2")),),
                trailing: Icon(Icons.arrow_forward_ios, size: 10.0, color: Colors.white,)
              ),
            );
          },
        )
        /* Import Wallet Button */
        // isHaveWallet == false ? 
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     color: getHexaColor("#363639"),
        //     border: Border.all(width: 1.0, color: getHexaColor("#2BB9CD")),
        //   ),
        //   margin: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0, top: 50.0),
        //   child: FlatButton(
        //     textColor: getHexaColor("#2BB9CD"),
        //     splashColor: Colors.white,
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        //     padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Container(
        //           margin: EdgeInsets.only(right: 5.0),
        //           child: Icon(Icons.save_alt,),
        //         ),
        //         Container(
        //           margin: EdgeInsets.only(left: 5.0),
        //           child: Text('Import Wallet'),
        //         )
        //       ],
        //     ),
        //     onPressed: (){
        //     },
        //   ),
        // )
        // : Container(),
        // /* Button Get Wallet */
        // isHaveWallet == false ? 
        // Container(
        //   margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     color: getHexaColor("#363639"),
        //     border: Border.all(width: 1.0, color: getHexaColor("#93E788")),
        //   ),
        //   child: FlatButton(
        //     splashColor: Colors.white,
        //     focusColor: Colors.white,
        //     textColor: getHexaColor("#93E788"),
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        //     padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Container(
        //           margin: EdgeInsets.only(right: 5.0),
        //           child: Icon(Icons.account_balance_wallet,),
        //         ),
        //         Container(
        //           margin: EdgeInsets.only(left: 5.0),
        //           child: Text('Get Wallet'),
        //         )
        //       ],
        //     ),
        //     onPressed: () async {
        //       dialogBox(context);
        //     },
        //   ),
        // )
        // : Container()
      ],
    ),
  );
}
