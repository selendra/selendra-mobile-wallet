import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';

Widget signUpFirstBodyWidget(
  BuildContext context,
  ModelSignUp _modelSignUp,
  Function popScreen, Function submitValidator, Function navigatePage, Function onChanged
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch, /* Stretch is fill cros axis */
    children: <Widget>[
      Column( /* Title of Zeetomic */
        children: <Widget>[
          zeeLogo(45.03, 47.62),
          Container(
            margin: EdgeInsets.only(top: 38.96),
            child: textDisplay(
              "Sign Up", 
              TextStyle(
                color: getHexaColor("#FFFFFF"),
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              )
            ),
          )
        ],
      ),
      Container( /* Body Sign Up */
        padding: EdgeInsets.only(top: 59.0),
        child: Column( /* User Input Field */
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 13.0), 
              child: inputField(
                _modelSignUp.bloc,
                context,
                "Phone number", _modelSignUp.countryCode, "PhoneScreen",
                false, 
                TextInputType.phone, _modelSignUp.controlPhoneNums,
                _modelSignUp.nodePhoneNums,
                onChanged,
                navigatePage
              )
            )
          ],
        ),
      ),
      flatCustomButton( /* Button Request Code */
        _modelSignUp.bloc,
        context,
        "Request Code", "signUpFirstScreen", greenColor,
        FontWeight.normal,
        size18,
        EdgeInsets.only(top: size10, bottom: size10),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(
          color: Color.fromRGBO(0,0,0,0.54),
          blurRadius: 5.0
        ),
        navigatePage
      ),
      Expanded(child: Container()),
      toLogin(context)
    ],
  );
}