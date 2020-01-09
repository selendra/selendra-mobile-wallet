/* Forgot Password Button */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget forgotPass(BuildContext context, dynamic color) {
  return InkWell(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: textDisplay(
        "Forgot Password?",
        TextStyle(
          color: color,
          fontSize: 18.0,
          fontWeight: FontWeight.bold
        )
      ),
    ),
    onTap: () { Navigator.pushNamed(context, '/forgotPasswordScreen'); },
  );
  // Align(
  //   alignment: Alignment.center,
  //   child: ,
  // );
}