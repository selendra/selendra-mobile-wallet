import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_apps/index.dart';

class ProfileUserBody extends StatelessWidget{
  
  final bool isHaveWallet; /* isHaveWallet By Default false */
  final Map<String, dynamic> userInfo;
  final MenuModel model;
  final PackageInfo packageInfo;
  final Function editProfile; final Function trxHistory;
  final Function trxActivity; final Function wallet;
  final Function changePin; final Function password;
  final Function addAssets; final Function signOut;
  final Function snackBar; final Function popScreen;
  final Function switchBio;

  ProfileUserBody({
    this.isHaveWallet, this.userInfo, this.model, this.packageInfo, this.editProfile,
    this.trxHistory, this.trxActivity, this.addAssets, this.changePin, this.password, this.wallet,
    this.signOut, this.snackBar,  this.popScreen, this.switchBio
  });

  Widget build(BuildContext context){

    print(model.switchBio);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
        Container(
          padding: EdgeInsets.all(20.25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // /* Close Button */
              Container(
                margin: EdgeInsets.only(bottom: 26.75),
                // height: 30.0,
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
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
                child: Icon(FontAwesomeIcons.solidUserCircle)
                // Image.asset(
                //   "assets/images/avatar.png",
                //   width: 100,
                //   height: 100,
                // )
              ),
              SwitchListTile(
                value: model.switchBio,
                onChanged: (value){
                  switchBio(value);
                },
              ),
              Container( /* User Name */
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10.0),
                child: 
                // userInfo.length == 0 
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
                //   userInfo['first_name'] == "" && 
                //   userInfo['last_name'] == "" ? "Username" : 
                //   "${userInfo['first_name'] == null ? '' : userInfo['first_name']+' '}${userInfo['mid_name'] == '' ? '' : userInfo['first_name']+' '} ${userInfo['last_name'] == null ? "" : userInfo['last_name']}",
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
              // Text("Version ${packageInfo.version ?? '0.0.0'}")
            ],
          )
        ),
        customListTile(context, FontAwesomeIcons.userEdit, "Profile", editProfile, maintenance: true),
        customListTile(context, FontAwesomeIcons.history, "Transaction", trxHistory),
        customListTile(context, FontAwesomeIcons.history, "Activity", trxActivity),
        customListTile(context, FontAwesomeIcons.wallet, "Wallets", wallet),
        customListTile(context, FontAwesomeIcons.unlock, "PIN", changePin),
        customListTile(context, FontAwesomeIcons.lock, "Password", password),
        customListTile(context, FontAwesomeIcons.plus, "Assets", addAssets),
        customListTile(context, FontAwesomeIcons.signOutAlt, "Sign out", signOut)
      ],
    );
  }
}
