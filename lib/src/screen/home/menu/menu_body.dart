import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/menu/account.dart';

class MenuBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final bool isHaveWallet; /* isHaveWallet By Default false */
  final Map<String, dynamic> userInfo;
  final MenuModel model;
  final PackageInfo packageInfo;
  final Function editProfile;
  final Function trxHistory;
  final Function trxActivity;
  final Function wallet;
  final Function changePin;
  final Function password;
  final Function addAssets;
  final Function snackBar;
  final Function popScreen;
  final Function switchBio;
  final Function createPin;
  final Function callBack;

  MenuBody(
      {this.globalKey,
      this.isHaveWallet,
      this.userInfo,
      this.model,
      this.packageInfo,
      this.editProfile,
      this.trxHistory,
      this.trxActivity,
      this.addAssets,
      this.changePin,
      this.password,
      this.wallet,
      this.snackBar,
      this.popScreen,
      this.switchBio,
      this.createPin,
      this.callBack});

  Widget build(BuildContext context) {
    return Column(children: [
      MenuHeader(userInfo: userInfo),

      // History
      MenuSubTitle(index: 0),

      MyListTile(
        index: 0,
        subIndex: 0,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrxHistory(userInfo['wallet'])));
        },
      ),

      MyListTile(
        index: 0,
        subIndex: 1,
        onTap: () {
          // callBack(_result);
          Navigator.pop(context, '');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TrxActivity()));
        },
      ),

      // Wallet
      MenuSubTitle(index: 1),

      MyListTile(
        index: 1,
        subIndex: 0,
        onTap: () {
          Navigator.pop(context);
          //createPin(context);
        },
      ),

      MyListTile(
        index: 1,
        subIndex: 1,
        onTap: () {
          Navigator.pop(context, '');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAsset()));
        },
      ),

      // Security
      MenuSubTitle(index: 2),

      MyListTile(
        index: 2,
        subIndex: 0,
        onTap: () {
          Navigator.pop(context, '');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChangePin()));
        },
      ),

      MyListTile(
        index: 2,
        subIndex: 1,
        onTap: () {
          Navigator.pop(context, '');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChangePassword()));
        },
      ),

      MyListTile(
        enable: false,
        index: 2,
        subIndex: 2,
        trailing: Switch(
          value: model.switchBio,
          onChanged: switchBio,
        ),
        onTap: null,
      ),

      // Account
      MenuSubTitle(index: 3),

      MyListTile(
        index: 3,
        subIndex: 0,
        onTap: () async {
          Navigator.popAndPushNamed(context, Account.route);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ReferralProgram())
          // );

          //snackBar(globalKey, "Invite friend feature under implement");
        },
      ),
    ]);
  }
}
