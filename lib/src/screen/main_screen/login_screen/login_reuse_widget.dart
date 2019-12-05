import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';

/* body widget */
Widget paddingScreenWidget(BuildContext context, Widget body) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width
      ), /* Get max height */
      padding: EdgeInsets.only(top: 102.42, left: leftRight40, right: leftRight40, bottom: 67.0),
      child: body,
    ),
  );
}

Widget noAccountWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      textDisplay(
        "Don't have account ? ", 
        TextStyle(
          color: getHexaColor("#ffffff"),
          fontSize: 18,
        )
      ),
      InkWell(
        child: textDisplay(
          "Sign up now",
          TextStyle(
            color: getHexaColor("#ffffff"),
            fontSize: 18,
          )
        ),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/signUpScreen');
        },
      )
    ],
  );
}
