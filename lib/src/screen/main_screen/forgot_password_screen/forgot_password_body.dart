import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_forgot_password.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget forgotPasswordBodyWidget(
  BuildContext context, 
  ModelForgotPassword _modelForgots,
  Function onChanged, Function popScreen
) {
  return Container(
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Forgot Password", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0,top: 59.0),
            child: Column(
              children: <Widget>[
                Container( /* Phone number field */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelForgots.bloc, 
                    context, "Phone number", "+855", "forgotsScreen", 
                    false, 
                    TextInputType.text, TextInputAction.done,
                    _modelForgots.controllerPhone, 
                    _modelForgots.nodePhone, 
                    onChanged, 
                    null
                  ),
                ),
                customFlatButton(
                  _modelForgots.bloc, 
                  context, 
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