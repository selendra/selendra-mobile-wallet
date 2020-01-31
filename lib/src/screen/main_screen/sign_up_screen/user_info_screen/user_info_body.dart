import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget userInfoBodyWidget(
  BuildContext _context, 
  ModelUserInfo _modelUserInfo,
  Function onChanged, Function changeGender, 
  Function validateFirstName, Function validateMidName, Function validateLastName,
  Function submitProfile, Function popScreen
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
        Form(
          key: _modelUserInfo.formStateAddUserInfo,
          child: Expanded( /* Body */
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
                        [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        TextInputType.text, TextInputAction.next,
                        _modelUserInfo.controlFirstName,
                        _modelUserInfo.nodeFirstName,
                        instanceValidate.validateUserInfo, onChanged, validateFirstName
                      ),
                    ),
                    Container( /* Mid Name Field */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        _context,
                        "Mid Name", null, "userInfoScreen",
                        false, 
                        [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        TextInputType.text, TextInputAction.next,
                        _modelUserInfo.controlMidName,
                        _modelUserInfo.nodeMidName,
                        instanceValidate.validateUserInfo, onChanged, validateMidName
                      ),
                    ),
                    Container( /* Last Name Field */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        _context,
                        "Last Name", null, "userInfoScreen",
                        false, 
                        [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        TextInputType.text, TextInputAction.next,
                        _modelUserInfo.controlLastName,
                        _modelUserInfo.nodeLastName,
                        instanceValidate.validateUserInfo, onChanged, validateLastName
                      ),
                    ),
                    Container( /* Gender Picker */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: customDropDown(
                        _modelUserInfo.genderLabel, 
                        ["Male", "Female"],
                        _modelUserInfo, 
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
                      _modelUserInfo.enable == false ? null : submitProfile
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
