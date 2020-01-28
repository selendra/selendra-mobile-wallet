import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';

/* body widget */
Widget paddingScreenWidget(BuildContext context, Widget child) {
  return Container( /* Create Whole Screen Background Color */
    decoration: scaffoldBGColor("#344051", "#222834"),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(top: 102.42, left: leftRight40, right: leftRight40, bottom: 52.0),
        constraints: BoxConstraints( /* Make Height And Widget To Fit Screen */
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width
        ),
        child: Column( /* Column Is A Flex Widget */
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible( /* Need Flexible Widget Inside Flex Widget */
              child: child,
            )
          ],
        ),
      ),
    ),
  );
}

Widget noAccountWidget(BuildContext context, dynamic colorSignUpText, String text) {
  return InkWell(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: textDisplay(
        text,
        TextStyle(
          fontWeight: FontWeight.bold,
          color: colorSignUpText,
          fontSize: 18,
        )
      ),
    ),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/signUpScreen');
    },
  );
}

Widget toLogin(BuildContext context) { /* Back To Login Screen*/
  return Align(
    alignment: Alignment.center,
    child: InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text('Back to login', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold))
      ),
      onTap: () { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginFirstScreen()));
      },
    ),
  );
}