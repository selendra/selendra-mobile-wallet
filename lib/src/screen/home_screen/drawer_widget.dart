/* Flutter Package */
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import '../../provider/reuse_widget.dart';

final fontSize = 16.0;

Widget drawerOnly(BuildContext context, ModelDashboard _modelDashBoard, String currentRoute, Function method) {
  return Drawer(
    child: Container(
      color: Colors.white30,
      child: Column(
        children: <Widget>[
          /* Header of drawer */
          DrawerHeader(
            decoration: BoxDecoration(
              color: getHexaColor(highThenBackgroundColor),
            ),
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/abstract_logo_vector.png",height: 100.0, width: double.infinity,),
                Text('Test version', style: TextStyle(fontWeight: FontWeight.w300, foreground: Paint()..shader = linearGradient),)
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 0.1),
              padding: EdgeInsets.only(top: 15.0),
              color: getHexaColor(highThenBackgroundColor),
              child: Column(
                children: <Widget>[
                  /* User Home */
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(OMIcons.home, color: getHexaColor( currentRoute == "dashboardScreen" ? lightBlueSky : textColor ),),
                        Container(
                          margin: EdgeInsets.only(right: 20.0),
                        ),
                        drawerText('Home', getHexaColor(currentRoute == "dashboardScreen" ? lightBlueSky : textColor), fontSize)
                      ],
                    ),
                    onTap: () {
                      if (currentRoute == "dashboardScreen") Navigator.pop(context);
                      else Navigator.pushReplacementNamed(context, '/dashboardScreen');
                    },
                  ),
                  /* User Profile */
                  /* FutureBuilder to check user stand where (Inactive, Active, Verifying, Verified)*/
                  FutureBuilder(
                    future: Provider.fetchStatusNWallet(),
                    builder: (context, snapshot){
                      return ListTile(
                        contentPadding: EdgeInsets.only(left: 20.0),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(OMIcons.accountCircle, color: getHexaColor(
                              currentRoute == "profileScreen" || currentRoute == "addProfileScreen" ? lightBlueSky : textColor)
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20.0),
                            ),
                            drawerText('Profile', getHexaColor(currentRoute == "profileScreen" || currentRoute == "addProfileScreen" ? lightBlueSky : textColor), fontSize)
                          ],
                        ),
                        onTap: () async {
                          // Navigator.push(context, CupertinoPageRoute(builder: (context) => ));
                          Navigator.pop(context);
                          // blurBackgroundDecoration(context, ProfileUser()); /* Navigate To Profile User */
                          // blurBackgroundDecoration(context, ProfileUserWidget());
                          // if (currentRoute == "profileScreen" || currentRoute == "addProfileScreen") Navigator.pop(context);
                          // else {
                          //   if (snapshot.data == null) {
                          //     Navigator.pushReplacementNamed(context, '/profileScreen');
                          //   } else if (snapshot.data['status_name'] == "Active"){
                          //     Navigator.pushReplacementNamed(context, '/addProfile');
                          //   } else if ( snapshot.data == null || snapshot.data['status_name'] == 'Verified'){
                          //     Navigator.pushReplacementNamed(context, '/profileScreen');
                          //   } else if (snapshot.data['status_name'] == "Verifying") {
                          //     Navigator.pushReplacementNamed(context, '/profileScreen');
                          //   }
                          // }
                        },
                      );
                    },
                  ),
                  ListTile( /* User Wallet */
                    contentPadding: EdgeInsets.only(left: 20.0),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(OMIcons.history, color: getHexaColor( currentRoute == "historyScreen" ? lightBlueSky : textColor)),
                        Container(
                          margin: EdgeInsets.only(right: 20.0),
                        ),
                        drawerText('History', getHexaColor(currentRoute == "historyScreen" ? lightBlueSky : textColor), fontSize)
                      ],
                    ),
                    onTap: () {
                      // if (currentRoute == "historyScreen") Navigator.pop(context);
                      // else blurBackgroundDecoration(context, TransactionHistoryWidget());
                    }
                  ),
                  /* User Setting */
                  // ListTile(
                  //   contentPadding: EdgeInsets.only(left: 20.0),
                  //   leading: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: <Widget>[
                  //       Icon(OMIcons.settings, color: getHexaColor( currentRoute == "settingScreen" ? lightBlueSky : textColor)),
                  //       Container(
                  //         margin: EdgeInsets.only(right: 20.0),
                  //       ),
                  //       drawerText('Setting', getHexaColor(currentRoute == "settingScreen" ? lightBlueSky : textColor), fontSize)
                  //     ],
                  //   ),
                  //   onTap: () {
                  //     if (currentRoute == "settingScreen") Navigator.pop(context);
                  //     else Navigator.pushReplacementNamed(context, '/settingScreen');
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
