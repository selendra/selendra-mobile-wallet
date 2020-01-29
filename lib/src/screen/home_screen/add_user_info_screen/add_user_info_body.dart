/* Flutter Package */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
/* Directory of file*/
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget addUserInfobodyWidget(
  ValidateMixin _validateInstance,
  BuildContext context, 
  List<String> genderList,
  ModelUserInfo _modelUserInfo,
  Function triggerImage,
  Function resetGender, Function validatorProfileUser, Function resetImage, 
  Function textChanged, Function clickNext, Function popScreen
  ) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
              containerTitle("Add Assets", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
              child: Column(
                children: <Widget>[
                  Container( /* Occupation Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context,
                      "Occupation", null, "addUserInfoScreen",
                      false, 
                      [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      TextInputType.text, TextInputAction.next,
                      _modelUserInfo.controlOccupation,
                      _modelUserInfo.nodeOccupatioin,
                      _validateInstance.validateOccupation,
                      null, null
                    ),
                  ),
                  Container( /* Nationality Screen */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context,
                      "Nationality", null, "addUserInfoScreen",
                      false, 
                      [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      TextInputType.text, TextInputAction.done,
                      _modelUserInfo.controlNationality,
                      _modelUserInfo.nodeNationality,
                      _validateInstance.validateNationality,
                      null, null
                    ),
                  ),
                  Container( /* Country */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker(context, "Country", "addUserInfoScreen", Icons.search, _modelUserInfo, null),
                  ),
                  Container( /* Upload porfile picture */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker(context, "Upload profile picture", "addUserInfoScreen", Icons.camera_alt, _modelUserInfo, triggerImage),
                  ),
                  _modelUserInfo.file != null ? Container( /* Image Display */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: Image.file(_modelUserInfo.file),
                  ) : Container(),
                  customFlatButton( /* Next Button */
                    context, 
                    "Next", "addUserInfoScreen", blueColor,
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
              ),
            ),
          ),
        )
      ],
    ),
  );
}