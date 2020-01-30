import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';

Widget signUpFirstBodyWidget(
  BuildContext context,
  ModelSignUp _modelSignUp,
  Function validateInput, Function onChanged,
  Function popScreen, Function navigatePage, Function tabBarSelectChanged,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center, /* Stretch is fill cros axis */
    children: <Widget>[
      logoWelcomeScreen("CBM_V1.png", 80.0, 80.0),
      Container(
        margin: EdgeInsets.only(top: 60.0),
        child: textDisplay(
          "Sign Up", 
          TextStyle(
            color: getHexaColor("#FFFFFF"),
            fontSize: 30.0,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      Container( /* User Choice Sign Up */
        margin: EdgeInsets.only(top: 30.0, bottom: 59.0),
        child: TabBar(
          controller: _modelSignUp.tabController,
          unselectedLabelColor: getHexaColor("#FFFFFF"),
          indicatorColor: getHexaColor(greenColor),
          labelColor: getHexaColor(greenColor),
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
      Form( /* Form Control User Field */
        key: _modelSignUp.formStateEmailPhone,
        child: Container( /* User Sign Up Choice Body */
          height: 100.0,
          child: TabBarView( /* Body Sign Up */
            controller: _modelSignUp.tabController,
            children: <Widget>[
              Container( /* Login By Email Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context,
                  "Email", null, "signUpFirstScreen",
                  false,
                  [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                  TextInputType.text, TextInputAction.done,
                  _modelSignUp.controlEmails,
                  _modelSignUp.nodeEmails,
                  validateInput, onChanged, navigatePage
                )
              ),
              Container( /* Sign By Phone Number Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context,
                  "Phone number", "${_modelSignUp.countryCode} ", "signUpFirstScreen",
                  false, 
                  [LengthLimitingTextInputFormatter(9), WhitelistingTextInputFormatter.digitsOnly],
                  TextInputType.phone, TextInputAction.done,
                  _modelSignUp.controlPhoneNums,
                  _modelSignUp.nodePhoneNums,
                  validateInput, onChanged, navigatePage
                )
              )
            ],
          ),
        ),
      ),
      customFlatButton( /* Button Request Code */
        context,
        "Sign up", 
        "signUpFirstScreen", greenColor,
        FontWeight.normal,
        size18,
        EdgeInsets.only(top: size10, bottom: size10),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(
          color: Color.fromRGBO(0,0,0,0.54),
          blurRadius: 5.0
        ),
        _modelSignUp.enable1 == false ? null : navigatePage
      ),
      Flexible(flex: 2, child: Container()),
      toLogin(context)
    ],
  );
}