import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/activity_screen/activity.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/add_asset_screen/add_asset.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_password_screen/change_password.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_pin_screen/change_pin.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/reuse_profile.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/transaction_history_screen.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';
import 'package:wallet_apps/src/service/services.dart';

Widget profileUserBodyWidget(
  bool isHaveWallet /* isHaveWallet By Default false */,
  BuildContext context,
  Map<String, dynamic> _userInfo,
  String _walletKey,
  Function snackBar,
  Function dialogBox,
  Function popScreen
) {
  /* Function */
  void navigateEditProfile(){
    Navigator.pop(context, '');
    Navigator.push(context, transitionRoute(UserInfo(_userInfo)));
  } 
  void navigateTrxHistory() {
    Navigator.pop(context, '');
    Navigator.push(context, transitionRoute(TransactionHistoryWidget(_walletKey)));
  }
  void navigateAcivity() { 
    Navigator.pop(context, '');
    Navigator.push(context, transitionRoute(Activity()));
  }
  void navigateGetWallet() async{
    await dialogBox(context); 
  }
  void navigateChangePIN() { 
    Navigator.push(context, transitionRoute(ChangePIN()));
  }
  void navigateChangePass() {
    Navigator.push(context, transitionRoute(ChangePassword()));
  }
  void navigateAddAssets() {
    Navigator.push(context, transitionRoute(AddAsset()));
  }
  void signOut() async {
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
  print(_userInfo);
  return Container(
    margin: EdgeInsets.all(19),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ /* User image */
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
                  border: Border.all(
                    width: 1, color: getHexaColor(greenColor))
                  ),
                child: Image.asset(
                  "assets/avatar.png",
                  width: 100,
                  height: 100,
                )
              ),
              Container( /* User Name */
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row( /* User Status */
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.check_circle,
                        color: getHexaColor(greenColor),
                      ),
                    ),
                    Text(
                      "Verified",
                      style: TextStyle(color: getHexaColor(greenColor)),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        Flexible(child: customListTile(context, Icons.sort, "Edit Profile", navigateEditProfile),),
        Flexible(child: customListTile(context, Icons.query_builder, "Transaction History", navigateTrxHistory),),
        Flexible(child: customListTile(context, Icons.query_builder, "Activity", navigateAcivity),),
        Flexible(child: customListTile(context, Icons.account_balance_wallet, "Get Wallet", navigateGetWallet),),
        Flexible(child: customListTile(context, Icons.lock, "Change PIN", navigateChangePIN),),
        Flexible(child: customListTile(context, Icons.lock, "Change Password", navigateChangePass),),
        Flexible(child: customListTile(context, Icons.add, "Add Assets", navigateAddAssets),),
        Flexible(child: customListTile(context, Icons.exit_to_app, "Sign Out", signOut),)
      ],
    ),
  );
}
