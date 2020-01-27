import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget forgotPasswordBodyWidget(
  BuildContext _context, 
  ModelSignUp _modelSignUp,
  Function onChanged, Function popScreen, Function requestCode
) {
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
                    _modelSignUp.bloc,
                    _context, "Phone number", "${_modelSignUp.countryCode} ", "forgotsScreen", 
                    false, 
                    TextField.noMaxLength,
                    TextInputType.number, TextInputAction.done,
                    _modelSignUp.controlPhoneNums, 
                    _modelSignUp.nodePhoneNums, 
                    validateInstance.validatePhone, onChanged, null
                  ),
                ),
                customFlatButton(
                  _modelSignUp.bloc, 
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
                  requestCode
                )
              ],
            )
          ),
        ),
      ],
    ),
  );
}