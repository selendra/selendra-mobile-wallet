import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_forgot_password.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget requestCodeBodyWidget(
  BuildContext context,
  ModelForgotPassword _modelForgots,
  Function popScreen, Function onChanged
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
              containerTitleAppBar("Request Code")
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
                    context, "Phone number", "+855", "requestScreen", 
                    false, 
                    TextInputType.text, 
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
                    context, "Enter SMS code", "+855", "forgotsScreen", 
                    false, 
                    TextInputType.text, 
                    _modelForgots.controllerSMS, 
                    _modelForgots.nodeSMS, 
                    onChanged, 
                    null
                  ),
                ),
                blueButton( /* Request Button */
                  _modelForgots.bloc, 
                  context, 
                  "Change Now", "forgotsScreen", greenColor,                     
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