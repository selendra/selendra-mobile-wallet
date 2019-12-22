import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';

/* body widget */
Widget paddingScreenWidget(BuildContext context, Widget body) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width
      ), /* Get max height */
      padding: EdgeInsets.only(top: 102.42, left: leftRight40, right: leftRight40, bottom: 52.0),
      child: body,
    ),
  );
}

Widget noAccountWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      textDisplay(
        "Don't have account? ", 
        TextStyle(
          color: getHexaColor("#ffffff"),
          fontSize: 18,
        )
      ),
      InkWell(
        child: textDisplay(
          "Sign up now",
          TextStyle(
            fontWeight: FontWeight.bold,
            color: getHexaColor(blueColor),
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

Widget toLogin(BuildContext context) { /* Back To Login Screen*/
  return Align(
    alignment: Alignment.center,
    child: InkWell(
      child: Text('Back to login', style: TextStyle(color: Colors.white, fontSize: 18.0)),
      onTap: () { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginFirstScreen()));
      },
    ),
  );
}