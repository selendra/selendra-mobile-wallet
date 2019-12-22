import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget userInfoBodyWidget(
  BuildContext context, 
  ModelSignUp _modelSignUp,
  Function popScreen, Function submit
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
              containerTitleAppBar("User Information")
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
                      _modelSignUp.bloc, 
                      context,
                      "First Name", null, "userInfoScreen",
                      false, 
                      TextInputType.text, TextInputAction.next,
                      _modelSignUp.controlFirstName,
                      _modelSignUp.nodeFirstName,
                      null, null
                    ),
                  ),
                  Container( /* Mid Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _modelSignUp.bloc, 
                      context,
                      "Mid Name", null, "userInfoScreen",
                      false, 
                      TextInputType.text, TextInputAction.next,
                      _modelSignUp.controlMidName,
                      _modelSignUp.nodeMidName,
                      null, null
                    ),
                  ),
                  Container( /* Last Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _modelSignUp.bloc, 
                      context,
                      "Last Name", null, "userInfoScreen",
                      false, 
                      TextInputType.text, TextInputAction.next,
                      _modelSignUp.controlLastName,
                      _modelSignUp.nodeLastName,
                      null, null
                    ),
                  ),
                  Container( /* Gender Picker */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker(
                      context, 
                      "Gender", "userInfoScreen", 
                      Icons.keyboard_arrow_down, 
                      _modelSignUp,
                      null
                    ),
                  ),
                  customDropDown("Gender", ["Male", "Femal"], _modelSignUp, null,),
                  customFlatButton( /* Submit Button */
                    _modelSignUp.bloc, 
                    context, 
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
                    submit
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
