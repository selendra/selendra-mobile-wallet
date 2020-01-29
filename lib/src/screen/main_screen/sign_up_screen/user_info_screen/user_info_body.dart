import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget userInfoBodyWidget(
  BuildContext _context, 
  ModelSignUp _modelSignUp,
  Function popScreen, Function submitProfile, Function changeGender
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
              containerTitle("User Information", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Expanded( /* Body */
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(left: 27.0, right: 27.0,top: 27.0),
              child: Column(
                children: <Widget>[
                  Container( /* First Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _context,
                      "First Name", null, "userInfoScreen",
                      false, 
                      TextField.noMaxLength,
                      TextInputType.text, TextInputAction.next,
                      _modelSignUp.controlFirstName,
                      _modelSignUp.nodeFirstName,
                      validateInstance.validateUserInfo, null, null
                    ),
                  ),
                  Container( /* Mid Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _context,
                      "Mid Name", null, "userInfoScreen",
                      false, 
                      TextField.noMaxLength,
                      TextInputType.text, TextInputAction.next,
                      _modelSignUp.controlMidName,
                      _modelSignUp.nodeMidName,
                      validateInstance.validateUserInfo, null, null
                    ),
                  ),
                  Container( /* Last Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _context,
                      "Last Name", null, "userInfoScreen",
                      false, 
                      TextField.noMaxLength,
                      TextInputType.text, TextInputAction.next,
                      _modelSignUp.controlLastName,
                      _modelSignUp.nodeLastName,
                      validateInstance.validateUserInfo, null, null
                    ),
                  ),
                  Container( /* Gender Picker */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: customDropDown(
                      _modelSignUp.genderLabel, 
                      ["Male", "Female"],
                      _modelSignUp, 
                      changeGender,
                    ),
                  ),
                  customFlatButton( /* Submit Button */
                    _context, 
                    "Submit", "userInfoScreen", 
                    greenColor,
                    FontWeight.normal,
                    size18,
                    EdgeInsets.only(top: 15.0, bottom: size10),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Color.fromRGBO(0,0,0,0.54),
                      blurRadius: 5.0
                    ), 
                    submitProfile
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
