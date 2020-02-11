import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';

Widget loginFirstBodyWidget( /* body widget */
  BuildContext context,
  ModelLogin _modelLogin,
  Function validateInput, Function onChanged, Function tabBarSelectChanged, Function navigatePage
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center, /* Stretch is fill cros axis */
    children: <Widget>[
      Column( /* Title of Zeetomic */
        children: <Widget>[
          // zeelogo
          logoWelcomeScreen("yinkok_256.png", 70.0, 47.62),
          Container(
            margin: EdgeInsets.only(top: 60.0),
            child: textDisplay(
              "Login",
              TextStyle(
                color: getHexaColor("#FFFFFF"),
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              )
            ),
          )
        ],
      ),
      Container( /* User Choice Log in */
        margin: EdgeInsets.only(top: 30.0, bottom: 59.0),
        child: TabBar(
          unselectedLabelColor: getHexaColor("#FFFFFF"),
          indicatorColor: getHexaColor(blueColor),
          labelColor: getHexaColor(blueColor),
          labelStyle: TextStyle(fontSize: 18.0),
          tabs: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: double.infinity,
              child: Text("Email"),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              alignment: Alignment.center,
              child: Text("Phone number"),
            )
          ],
          onTap: tabBarSelectChanged,
        ),
      ),
      Form(
        key: _modelLogin.formState1,
        child: Container(
          height: 100.0,
          child: TabBarView( /* Body Sign Up */
            children: <Widget>[
              Container( /* Login By Email Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context,
                  "Email",
                  null,
                  "loginFirstScreen",
                  false,
                  [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                  TextInputType.text,
                  TextInputAction.done,
                  _modelLogin.controlEmails,
                  _modelLogin.nodeEmails,
                  validateInput, onChanged, navigatePage
                )
              ),
              Container( /* Sign By Phone Number Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context,
                  "Phone number",
                  "${_modelLogin.countryCode} ",
                  "loginFirstScreen",
                  false,
                  [LengthLimitingTextInputFormatter(9), WhitelistingTextInputFormatter.digitsOnly],
                  TextInputType.phone,
                  TextInputAction.done,
                  _modelLogin.controlPhoneNums,
                  _modelLogin.nodePhoneNums,
                  validateInput, onChanged, navigatePage
                )
              )
            ],
          ),
        ),
      ),
      Container(
        child: customFlatButton( /* Button login */
          context,
          "Login",
          "loginFirstScreen",
          blueColor,
          FontWeight.bold,
          size18,
          EdgeInsets.only(top: size10, bottom: size10),
          EdgeInsets.only(top: size15, bottom: size15),
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.54), blurRadius: 5.0),
          _modelLogin.enable1 == false ? null : navigatePage
        ),
      ),
      Expanded(child: Container()),
      Row(
        /* Bottom Navigator */
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          noAccountWidget(context, Colors.white, "Create Account"),
          Text(
            "  |  ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          forgotPass(context, Colors.white),
        ],
      ),
    ],
  );
}

/* To Register */
Widget register(BuildContext context) {
  return InkWell(
    child: Text('Sign up',
      style: TextStyle(
      color: getHexaColor(lightBlueSky), fontWeight: FontWeight.bold)
    ),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/signUp');
    },
  );
}

/* Forgot Password Button */
Widget forgotPasswordBody(BuildContext context) {
  return InkWell(
    child: Text('Forgot password?',
      style: TextStyle(
        color: getHexaColor(lightBlueSky),
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline
      )
    ),
    onTap: () {
      Navigator.pushNamed(context, '/forgotPasswordScreen');
    },
  );
}
