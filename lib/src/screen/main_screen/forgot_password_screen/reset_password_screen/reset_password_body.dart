import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget resetPasswordBody(
  BuildContext _context,
  ModelSignUp _modelForgots,
  Function onChanged, Function submitResetPassword, Function popScreen, 
){
  return Container(
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          _context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Change Password", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Expanded( /* Body */
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0,top: 59.0),
            child: Column(
              children: <Widget>[
                Container( /* Phone number field */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelForgots.bloc, 
                    _context, "Phone number", "${_modelForgots.countryCode} ", "resetPasswordScreen", 
                    false, 
                    TextField.noMaxLength,
                    TextInputType.number, TextInputAction.next,
                    _modelForgots.controlPhoneNums, 
                    _modelForgots.nodePhoneNums, 
                    onChanged, 
                    null
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelForgots.bloc, 
                    _context, "New Password", null, "resetPasswordScreen", 
                    true, 
                    TextField.noMaxLength,
                    TextInputType.text, TextInputAction.next,
                    _modelForgots.controlPasswords, 
                    _modelForgots.nodePassword, 
                    onChanged, 
                    null
                  ),
                ),
                Container( /* SMS code field */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelForgots.bloc, 
                    _context, "Confirm New Password", null, "resetPasswordScreen", 
                    true, 
                    TextField.noMaxLength,
                    TextInputType.text, TextInputAction.next,
                    _modelForgots.controlConfirmPasswords, 
                    _modelForgots.nodeConfirmPasswords, 
                    onChanged, 
                    null
                  ),
                ),
                Container( /* Verify Code field */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelForgots.bloc, 
                    _context, "Reset code", null, "resetPasswordScreen", 
                    false, 
                    TextField.noMaxLength,
                    TextInputType.number, TextInputAction.next,
                    _modelForgots.controlResetCode, 
                    _modelForgots.nodeResetCode, 
                    onChanged, 
                    null
                  ),
                ),
                customFlatButton( /* Request Button */
                  _modelForgots.bloc, 
                  _context, 
                  "Request Code", "resetPasswordScreen", greenColor,                    
                  FontWeight.normal,
                  size18,
                  EdgeInsets.only(top: 15.0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ),
                  submitResetPassword
                )
              ],
            )
          ),
          ),
        ),
      ],
    ),
  );
}