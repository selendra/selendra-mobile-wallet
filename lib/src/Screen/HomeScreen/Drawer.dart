/* Flutter Package */
import 'package:Wallet_Apps/src/Provider/Provider_General.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
/* File Path */
import '../../Provider/Hexa_Color_Convert.dart';
import '../../Provider/Reuse_Widget.dart';

final whiteColor = Colors.white;
final fontSize = 16.0;

Widget drawerOnly(BuildContext context, Function method) {
  /* Sign Out Button Widget */
  // Widget signOutButton(Function method) {
  //   return Container(
  //     decoration: signOutColor(),
  //     child: FlatButton(
  //       padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
  //       color: Color(convertHexaColor('#CD1C32')),
  //       child: new Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(Icons.exit_to_app,color: Colors.white,),
  //           Container(
  //             margin: EdgeInsets.only(right: 10.0),
  //           ),
  //           Text(
  //             'Log out',
  //             style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0, color: whiteColor),
  //           )
  //         ],
  //       ),
  //       onPressed: method
  //     ),
  //   );
  // }
  return Drawer(
    child: Container(
      color: Colors.white30,
      child: Column(
        children: <Widget>[
          /* Header of drawer */
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(convertHexaColor(backgroundColor)),
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
              padding: EdgeInsets.only(left: 15.0, top: 15.0),
              color: Color(convertHexaColor(backgroundColor)),
              child: Column(
                children: <Widget>[
                  /* User Home */
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(OMIcons.home, color: whiteColor,),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text('Home', style: TextStyle(color: whiteColor, fontSize: fontSize),)
                      ],
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/homeScreen');
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
                            Icon(OMIcons.accountCircle, color: whiteColor),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                            ),
                            Text('Profile', style: TextStyle(color: whiteColor, fontSize: fontSize))
                          ],
                        ),
                        onTap: () {
                          // Navigator.pushNamed(context, "/addProfile");
                          if (snapshot.data == null) {
                            Navigator.pushReplacementNamed(context, '/profileScreen');
                          } else if (snapshot.data['status_name'] == "Active"){
                            Navigator.pushReplacementNamed(context, '/addProfile');
                          } else if ( snapshot.data == null || snapshot.data['status_name'] == 'Verified'){
                            Navigator.pushReplacementNamed(context, '/profileScreen');
                          } else if (snapshot.data['status_name'] == "Verifying") {
                            Navigator.pushReplacementNamed(context, '/profileScreen');
                          }
                        },
                      );
                    },
                  ),
                  /* User Wallet */
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(OMIcons.history, color: whiteColor),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text('History', style: TextStyle(color: whiteColor, fontSize: fontSize))
                      ],
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/historyScreen');
                    },
                  ),
                  /* User Setting */
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(OMIcons.settings, color: whiteColor),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text('Setting', style: TextStyle(color: whiteColor, fontSize: fontSize))
                      ],
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/settingScreen');
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(OMIcons.exitToApp, color: whiteColor),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text('Log out', style: TextStyle(color: whiteColor, fontSize: fontSize))
                      ],
                    ),
                    onTap: method
                  )
                ],
              ),
            ),
          ),
          // signOutButton(method),
        ],
      ),
    ),
  );
}
