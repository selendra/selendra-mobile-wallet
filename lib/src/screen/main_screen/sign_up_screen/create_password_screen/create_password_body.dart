import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget createPasswordBodyWidget(
  BuildContext _context,
  ModelSignUp _modelSignUp,
  Function validatePass1, Function validatePass2,
  Function onChanged, Function popScreen,
  Function changeFocus, Function navigatePage
){
  return Column(
    children: <Widget>[
      containerAppBar( /* AppBar */
        _context,
        Row(
          children: <Widget>[
            iconAppBar( /* Arrow Back Button */
              Icon(Icons.arrow_back, color: Colors.white),
              Alignment.centerLeft,
              EdgeInsets.all(0),
              popScreen,
            ),
            containerTitle("Create Password", double.infinity, Colors.white, FontWeight.bold)
          ],
        )
      ),
      Expanded( /* Body */
        child: Container(
          margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
          child: Form(
            key: _modelSignUp.formStatePassword,
            child: Column(
            children: <Widget>[
              Container( /* Password Field */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                  _context,
                  "Password",
                  null,
                  "createPasswordScreen",
                  true,
                  [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                  TextInputType.text,
                  TextInputAction.next,
                  _modelSignUp.controlPassword,
                  _modelSignUp.nodePassword,
                  validatePass1, onChanged, changeFocus
                ),
              ),
              Container( /* Confirm Password Field */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                  _context,
                  "Confirm Password",
                  null,
                  "createPasswordScreen",
                  true,
                  [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                  TextInputType.text,
                  TextInputAction.done,
                  _modelSignUp.controlControlPassword,
                  _modelSignUp.nodeConfirmPassword,
                  validatePass2, onChanged, 
                  _modelSignUp.enable2 == true ? navigatePage : null
                ),
              ),
              _modelSignUp.isMatch == true
              ? Container()
              : Text(
                "Confirm password not match !",
                style: TextStyle(fontSize: 18.0, color: Colors.red),
              ),
              customFlatButton( /* Button Request Code */
                _context,
                "Sign Up Now",
                "signUpFirstScreen",
                greenColor,
                FontWeight.normal,
                size18,
                EdgeInsets.only(top: size10, bottom: size10),
                EdgeInsets.only(top: size15, bottom: size15),
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.54), blurRadius: 5.0),
                _modelSignUp.enable2 == true ? navigatePage : null
              )
            ],
          ),
          ),
        ),
      )
    ],
  );
}
