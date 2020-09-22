import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/index.dart';

class MenuBody extends StatelessWidget{
  
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
  final Function callBack;

  MenuBody({
    this.isHaveWallet, this.userInfo, this.model, this.packageInfo, this.editProfile,
    this.trxHistory, this.trxActivity, this.addAssets, this.changePin, this.password, this.wallet,
    this.signOut, this.snackBar,  this.popScreen, this.switchBio,
    this.callBack
  });

  Widget build(BuildContext context){
    return Column(
      children: [

        MenuHeader(),

        // History
        MenuSubTitle(index: 0),

        MyListTile(
          index: 0,
          subIndex: 0,
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => TrxHistory("hello"))
            );
          },
        ),

        MyListTile(
          index: 0,
          subIndex: 1,
          onTap: () {
            // callBack(_result);
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => TrxActivity())
            );
          },
        ),

        // Wallet
        MenuSubTitle(index: 1),

        MyListTile(
          index: 1,
          subIndex: 0,
          onTap: (){},
        ),

        MyListTile(
          index: 1,
          subIndex: 1,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AddAsset())
            );
          },
        ),

        // Security
        MenuSubTitle(index: 2),

        MyListTile(
          index: 2,
          subIndex: 0,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ChangePin())
            );
          },
        ),

        MyListTile(
          index: 2,
          subIndex: 1,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ChangePassword())
            );
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
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  title: Center(
                    child: textScale(
                      text: "Are you sure you want to exit?",
                      hexaColor: "#000000",
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text("No"),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        dialogLoading(context, content: "Logging out");
                        AppServices.clearStorage();
                        await Future.delayed(Duration(seconds: 1), () {
                          // Close Button
                          Navigator.pop(context);
                          // Close Dialog Loading
                          Navigator.pop(context);
                          // Close Drawer
                          Navigator.pop(context);
                          callBack({'log_out': true});
                        });
                      },
                    )
                  ],
                );
              }
            );
          },
        ),
      ]
    );
    
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[ 
    //     Container(
    //       // padding: EdgeInsets.all(20.25),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           // Avatar Image
    //           // Icon(
    //           //   FontAwesomeIcons.solidUserCircle,
    //           //   size: 100.0,
    //           //   color: Colors.white.withOpacity(0.2)
    //           // ),
    //           // User Name
    //           Container(
    //             alignment: Alignment.center,
    //             margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
    //             child: 
    //             // userInfo.length == 0 
    //             // ? 
    //             Text(
    //               'User name',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.w400, 
    //                 fontSize: 25,
    //               ),
    //               textAlign: TextAlign.center,
    //             ) 
    //             // : Text(
    //             //   userInfo['first_name'] == "" && 
    //             //   userInfo['last_name'] == "" ? "Username" : 
    //             //   "${userInfo['first_name'] == null ? '' : userInfo['first_name']+' '}${userInfo['mid_name'] == '' ? '' : userInfo['first_name']+' '} ${userInfo['last_name'] == null ? "" : userInfo['last_name']}",
    //             //   style: TextStyle(
    //             //     fontWeight: FontWeight.w400, 
    //             //     fontSize: 25,
    //             //   ),
    //             //   textAlign: TextAlign.center,
    //             // ),
    //           ),
    //           // Container(
    //           //   padding: EdgeInsets.only(bottom: 10.0),
    //           //   child: Row( /* User Status */
    //           //     mainAxisAlignment: MainAxisAlignment.center,
    //           //     children: <Widget>[
    //           //       Container(
    //           //         margin: EdgeInsets.only(right: 5.0),
    //           //         child: Icon(
    //           //           Icons.check_circle,
    //           //           color: getHexaColor(greenColor),
    //           //         ),
    //           //       ),
    //           //       // Text(
    //           //       //   "Verified",
    //           //       //   style: TextStyle(color: getHexaColor(greenColor)),
    //           //       // )
    //           //     ],
    //           //   ),
    //           // ),
    //           Text("Demo version")
    //           // Text("Version ${packageInfo.version ?? '0.0.0'}")
    //         ],
    //       )
    //     ),
    //     // SwitchListTile(
    //     //   value: model.switchBio,
    //     //   onChanged: (value){
    //     //     switchBio(value);
    //     //   },
    //     // ),
    //     // Container(
    //     //   // padding: EdgeInsets.only(left: 19.0, right: 19.0),
    //     //   decoration: BoxDecoration(
    //     //     border: Border(
    //     //       top: BorderSide(
    //     //         width: 1, color: Colors.white.withOpacity(0.2)
    //     //       )
    //     //     )
    //     //   ),
    //     //   child: Switch(
    //     //     // title: Row(
    //     //     //   children: [
    //     //     //     FaIcon(
    //     //     //       FontAwesomeIcons.fingerprint,
    //     //     //       color: Colors.white
    //     //     //     ),

    //     //     //     Text(
    //     //     //       'Finger print',
    //     //     //       style: TextStyle(
    //     //     //         fontWeight: FontWeight.w400,
    //     //     //         color: getHexaColor("#EFF0F2")
    //     //     //       ),
    //     //     //     )
    //     //     //   ],
    //     //     // ),
    //     //     value: model.switchBio,
    //     //     onChanged: (value){
    //     //       switchBio(value);
    //     //     },
    //     //   )
    //       // Row(
    //       //   children: [
    //       //     FaIcon(
    //       //       FontAwesomeIcons.fingerprint,
    //       //       color: Colors.white
    //       //     ),

    //       //     Text(
    //       //       'Finger print',
    //       //       style: TextStyle(
    //       //         fontWeight: FontWeight.w400,
    //       //         color: getHexaColor("#EFF0F2")
    //       //       ),
    //       //     ),

    //       //     Container(
    //       //       height: 20.0,
    //       //       width: 20.0,
    //       //       child: SwitchListTile(
    //       //         value: model.switchBio,
    //       //         onChanged: (value){
    //       //           switchBio(value);
    //       //         },
    //       //       )
    //       //     )
    //       //   ],
    //       // ),
    //     // ),
    //     Container(
    //       padding: EdgeInsets.only(left: 19.0),
    //       child: ListTile(
    //     //   // padding: EdgeInsets.only(left: 19.0, right: 19.0),
    //         contentPadding: EdgeInsets.all(0),
    //         leading: Container(
    //           padding: EdgeInsets.all(0),
    //           // child: FaIcon(
    //           //   FontAwesomeIcons.fingerprint,
    //           //   color: Colors.white
    //           // ),
    //         ),
    //         title: Text(
    //           'Finger print',
    //           style: TextStyle(
    //             fontWeight: FontWeight.w400,
    //             color: hexaCodeToColor("#EFF0F2")
    //           ),
    //         ),
    //         trailing: Switch(
    //           value: model.switchBio,
    //           onChanged: (value){
    //             switchBio(value);
    //           },
    //         ),
    //         // onTap:  
    //       )
    //     ),
    //     // customListTile(context, FontAwesomeIcons.userEdit, "Profile", editProfile, maintenance: true),
    //     // customListTile(context, FontAwesomeIcons.history, "Transaction", trxHistory),
    //     // customListTile(context, FontAwesomeIcons.history, "Activity", trxActivity),
    //     // customListTile(context, FontAwesomeIcons.wallet, "Wallets", wallet),
    //     // customListTile(context, FontAwesomeIcons.unlock, "PIN", changePin),
    //     // customListTile(context, FontAwesomeIcons.lock, "Password", password),
    //     // customListTile(context, FontAwesomeIcons.plus, "Assets", addAssets),
    //     // customListTile(context, FontAwesomeIcons.signOutAlt, "Sign out", signOut)
    //   ],
    // );
  }
}
