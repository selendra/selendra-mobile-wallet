import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_forgot_password.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget changePasswordBodyWidget(
  BuildContext _context,
  ModelForgotPassword _modelForgots,
  Function popScreen, Function onChanged,
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
          child: Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0,top: 59.0),
            child: Column(
              children: <Widget>[
                Container( /* Phone number field */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelForgots.bloc, 
                    _context, "New Password", null, "changePasswordScreen", 
                    false, 
                    TextInputType.text, TextInputAction.next,
                    _modelForgots.controllerPhone, 
                    _modelForgots.nodePhone, 
                    onChanged, 
                    null
                  ),
                ),
                Container( /* SMS code field */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelForgots.bloc, 
                    _context, "Confirm New Password", null, "forgotsScreen", 
                    false, 
                    TextInputType.text, TextInputAction.next,
                    _modelForgots.controllerSMS, 
                    _modelForgots.nodeSMS, 
                    onChanged, 
                    null
                  ),
                ),
                customFlatButton( /* Request Button */
                  _modelForgots.bloc, 
                  _context, 
                  "Request Code", "forgotsScreen", greenColor,                    
                  FontWeight.normal,
                  size18,
                  EdgeInsets.only(top: 15.0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ),
                  null
                )
              ],
            )
          ),
        ),
      ],
    ),
  );
}