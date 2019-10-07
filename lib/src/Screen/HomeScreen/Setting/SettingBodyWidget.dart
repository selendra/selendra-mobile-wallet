import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:flutter/material.dart';

Widget bodyWidget(
  BuildContext context,
  Map<String, dynamic> userData,
  TextEditingController fullNameControl, TextEditingController emailControl, TextEditingController passwordControl
) {
  return Container(
    margin: EdgeInsets.all(margin4),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /* Avatar Profile */
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
              color: Colors.grey[800],
              width: 2.0
            ),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/avatar.png')
                // userData['profile_img'] == null ? AssetImage('assets/avatar.png') :
                // userData['profile_img'] == "" ? AssetImage('assets/avatar.png') : NetworkImage(userData['profile_img'])
            )
          ),
          child: InkWell(
            onTap: () {
              dialog(context, Text("You pressed photo"), Text("Edit"));
            },
          ),
        ),
        /* Full Name */
        textFieldDisplay(false, fullNameControl, false, "Full name", null),
        /* Email */
        textFieldDisplay(false, emailControl, false, "Email", null),
        /* Password */
        textFieldDisplay(false, passwordControl, true, "Password", null),
      ],
    ),
  );
}