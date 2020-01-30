import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget loginSecondBodyWidget( /* body widget */
  BuildContext context, ModelLogin _modelLogin,
  Function validateInput, Function validatePassword,
  Function onChanged, Function checkInputAndValidate
){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center, /* Stretch is fill cros axis */
    children: <Widget>[
      textDisplay( /* Title of Zeetomic */
        "Login",
        TextStyle(
          color: getHexaColor("ffffff"),
          fontSize: 30.0,
          fontWeight: FontWeight.bold
        )
      ),
      Container( /* Body login */
        margin: EdgeInsets.only(top: 59.0),
        child: Form(
          key: _modelLogin.formState2,
          child: userLogin( /* User Input Field */
            context,
            _modelLogin,
            validateInput, validatePassword,
            onChanged, checkInputAndValidate
          ),
        )
      ),
      customFlatButton( /* Button login */
        context,
        "Login",
        "loginSecondScreen",
        blueColor,
        FontWeight.bold,
        size18,
        EdgeInsets.only(top: size10, bottom: 0),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.54), blurRadius: 5.0),
        _modelLogin.enable2 == false ? null : checkInputAndValidate
      ),
      Expanded(flex: 2, child: Container()),
      Row( /* Bottom Navigator */
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

Widget userLogin( /* Column of User Login */
  BuildContext context,
  ModelLogin _modelLogin,
  Function validateInput, Function validatePassword, 
  Function onChanged,
  Function checkInputAndValidate
){
  return Column(
    children: <Widget>[
      Container( /* Email & Phone Number Input Field*/
        margin: EdgeInsets.only(bottom: 13.0),
        child: inputField(
          context,
          _modelLogin.label == "email" ? "Email" : "Phone number",
          _modelLogin.label == "email" ? null : "${_modelLogin.countryCode} ",
          "loginSecondScreen",
          false,
          _modelLogin.label == "email" 
          ? [LengthLimitingTextInputFormatter(TextField.noMaxLength)] /* If Label Equal Email Just Control Length Input Format */
          : [LengthLimitingTextInputFormatter(9), WhitelistingTextInputFormatter.digitsOnly], /* Else Add Condition 0-9 Only */
          _modelLogin.controlEmails.text != "" ? TextInputType.text : TextInputType.phone,
          TextInputAction.next,
          _modelLogin.label == "email" ? _modelLogin.controlEmails : _modelLogin.controlPhoneNums,
          _modelLogin.label == "email" ? _modelLogin.nodeEmails : _modelLogin.nodePhoneNums,
          validateInput, onChanged, null
        )
      ),
      Container( /* Password Input Field */
        margin: EdgeInsets.only(bottom: 25.0),
        child: inputField(
          context,
          "Password",
          null,
          "loginSecondScreen",
          true,
          [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
          TextInputType.text,
          TextInputAction.done,
          _modelLogin.controlPasswords,
          _modelLogin.nodePasswords,
          validatePassword, onChanged, checkInputAndValidate
        ),
      ),
    ],
  );
}

/* To Register */
Widget register(BuildContext context) {
  return InkWell(
    child: Text(
      'Sign up',
      style: TextStyle(
        color: getHexaColor(lightBlueSky), fontWeight: FontWeight.bold
      )
    ),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/signUp');
    },
  );
}
