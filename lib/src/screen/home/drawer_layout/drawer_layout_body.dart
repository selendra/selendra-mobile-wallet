import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_apps/index.dart';

Widget profileUserBody(
  bool isHaveWallet /* isHaveWallet By Default false */,
  BuildContext context,
  Map<String, dynamic> _userInfo, 
  PackageInfo _packageInfo,
  Function navigateEditProfile, Function navigateTrxHistory,
  Function navigateAcivity, Function navigateGetWallet,
  Function navigateChangePIN, Function navigateChangePass,
  Function navigateAddAssets, Function signOut,
  Function snackBar, Function dialogBox, Function popScreen
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[ /* User image */
      Container(
        padding: EdgeInsets.all(20.25),
        child:
          Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container( /* Close Button */
              margin: EdgeInsets.only(bottom: 26.75),
              // height: 30.0,
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.all(10.0),
                color: getHexaColor("#97AAC3"),
                iconSize: 30.0,
                alignment: Alignment.topRight,
                icon: Icon(Icons.arrow_back),
                onPressed: popScreen,
              ),
            ),
            Container( /* Avatar Image */
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                border: Border.all(
                  width: 1, color: getHexaColor(AppColors.greenColor))
                ),
              child: Image.asset(
                "assets/images/avatar.png",
                width: 100,
                height: 100,
              )
            ),
            Container( /* User Name */
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10.0),
              child: 
              // _userInfo.length == 0 
              // ? 
              Text(
                'User name',
                style: TextStyle(
                  fontWeight: FontWeight.w400, 
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ) 
              // : Text(
              //   _userInfo['first_name'] == "" && 
              //   _userInfo['last_name'] == "" ? "Username" : 
              //   "${_userInfo['first_name'] == null ? '' : _userInfo['first_name']+' '}${_userInfo['mid_name'] == '' ? '' : _userInfo['first_name']+' '} ${_userInfo['last_name'] == null ? "" : _userInfo['last_name']}",
              //   style: TextStyle(
              //     fontWeight: FontWeight.w400, 
              //     fontSize: 25,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
            ),
            // Container(
            //   padding: EdgeInsets.only(bottom: 10.0),
            //   child: Row( /* User Status */
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Container(
            //         margin: EdgeInsets.only(right: 5.0),
            //         child: Icon(
            //           Icons.check_circle,
            //           color: getHexaColor(greenColor),
            //         ),
            //       ),
            //       // Text(
            //       //   "Verified",
            //       //   style: TextStyle(color: getHexaColor(greenColor)),
            //       // )
            //     ],
            //   ),
            // ),
            Text("Demo version")
            // Text("Version ${_packageInfo.version ?? '0.0.0'}")
          ],
        )
      ),
      customListTile(context, FontAwesomeIcons.solidEdit, "Edit Profile", navigateEditProfile),
      customListTile(context, Icons.query_builder, "Transaction History", navigateTrxHistory),
      customListTile(context, Icons.query_builder, "Activity", navigateAcivity),
      customListTile(context, Icons.account_balance_wallet, "Get Wallet", navigateGetWallet),
      customListTile(context, Icons.lock, "Change PIN", navigateChangePIN),
      customListTile(context, Icons.lock, "Change Password", navigateChangePass),
      customListTile(context, Icons.add, "Add Assets", navigateAddAssets),
      customListTile(context, Icons.exit_to_app, "Sign Out", signOut)
    ],
  );
}
