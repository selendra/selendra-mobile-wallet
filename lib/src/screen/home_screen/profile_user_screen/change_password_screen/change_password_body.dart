import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_change_password.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget changePasswordBodyWidget(
  BuildContext _context, ModelChangePassword _model,
  Function validateOldPass, Function validateNewPass, Function validateConfirmPass,
  Function onSubmitted, Function onChanged, 
  Function submitPassword, Function popScreen
) {
  return Container(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 6.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          _context,
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle(
                "Change Password", 
                double.infinity, 
                Colors.white,
                FontWeight.bold
              )
            ],
          )
        ),
        Form( /* Body Change Password */
          key: _model.formStateChangePassword,
          child: Expanded( 
            child: Container(
              margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      /* Old Password */
                      margin: EdgeInsets.only(bottom: 12.0, top: 10.0),
                      child: inputField(
                        _context,
                        "Old Password",
                        "",
                        "changePasswordScreen",
                        true,
                        [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        TextInputType.text,
                        TextInputAction.next,
                        _model.controlOldPassword,
                        _model.nodeOldPassword,
                        validateOldPass, onChanged, onSubmitted
                      ),
                    ),
                    Container( /* New Password */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        _context,
                        "New Password",
                        "",
                        "changePasswordScreen",
                        true,
                        [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        TextInputType.text,
                        TextInputAction.next,
                        _model.controlNewPassword,
                        _model.nodeNewPassword,
                        validateNewPass, onChanged, onSubmitted
                      ),
                    ),
                    Container( /* Old Password */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        _context,
                        "Confirm Password",
                        "",
                        "changePasswordScreen",
                        true,
                        [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        TextInputType.text,
                        TextInputAction.done,
                        _model.controlConfirmPassword,
                        _model.nodeConfirmPassword,
                        validateConfirmPass, onChanged, onSubmitted
                      ),
                    ),
                    customFlatButton(
                      _context,
                      "Change Now",
                      "changePasswordScreen",
                      blueColor,
                      FontWeight.normal,
                      size18,
                      EdgeInsets.only(top: 15.0),
                      EdgeInsets.only(top: size15, bottom: size15),
                      BoxShadow(
                        color: Color.fromRGBO(
                          0, 0, 0, _model.enable == false ? 0 : 0.54
                        ), 
                        blurRadius: 5.0
                      ),
                      _model.enable == false ? null : submitPassword
                    )
                  ],
                ),
              )
            )
          ),
        )
      ],
    ),
  );
}
