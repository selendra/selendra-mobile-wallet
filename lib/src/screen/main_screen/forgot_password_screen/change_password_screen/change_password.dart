import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_forgot_password.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/change_password_screen/change_password_body.dart';

class ChangePassword extends StatefulWidget{

  final ModelForgotPassword _modelForgots;

  ChangePassword(this._modelForgots);

  @override
  State<StatefulWidget> createState() {
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePassword> {

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String label, String changed){

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0,
        color1, color2,
        changePasswordBodyWidget(context, widget._modelForgots, popScreen, onChanged)
      ),
    );
  }
}