import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
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
  Map<String, dynamic> userData,
  ModelSignUp _modelSignUp,
  Function snackBar,
  Function dialogBox,
  Function popScreen
) {

  /* Function */
  void navigateEditProfile() => Navigator.push(context, transitonRoute(UserInfo(_modelSignUp)));
  void navigateTrxHistory() => Navigator.push(context, transitonRoute(TransactionHistoryWidget(_modelSignUp)));
  void navigateAcivity() => Navigator.push(context, transitonRoute(Activity()));
  void navigateGetWallet() async => await dialogBox(context); 
  void navigateChangePIN() => Navigator.push(context, transitonRoute(ChangePIN()));
  void navigateChangePass() => Navigator.push(context, transitonRoute(ChangePassword()));
  void navigateAddAssets() => Navigator.push(context, transitonRoute(AddAsset()));
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
              Container(
                /* Close Button */
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
              Container(
                /* User Name */
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
        customListTile(context, Icons.sort, "Edit Profile", navigateEditProfile),
        customListTile(context, Icons.query_builder, "Transaction History", navigateTrxHistory),
        customListTile(context, Icons.query_builder, "Activity", navigateAcivity),
        customListTile(context, Icons.account_balance_wallet, "Get Wallet", navigateGetWallet),
        customListTile(context, Icons.lock, "Change PIN", navigateChangePIN),
        customListTile(context, Icons.lock, "Change Password", navigateChangePass),
        customListTile(context, Icons.add, "Add Assets", navigateAddAssets),
        customListTile(context, Icons.exit_to_app, "Sign Out", signOut)
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
