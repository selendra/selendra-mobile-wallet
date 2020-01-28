import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_forgot_pass.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/forgot_password_body.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/reset_password_screen/reset_password.dart';

class ForgotPassword extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  
  ModelForgotPassword _modelForgotPassword = ModelForgotPassword();

  void onChanged(String label, String changed){

  }

  void requestCode(BuildContext context) async {
    dialogLoading(context);
    await forgetPassword(_modelForgotPassword).then((_response) async {
      Navigator.pop(context);
      await dialog(context, Text(_response['message']), Icon(Icons.done));
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(_modelForgotPassword)));
    });
  }

  void popScreen() {
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0,
        color1, color2,
        forgotPasswordBodyWidget(context, _modelForgotPassword, onChanged, popScreen, requestCode)
      ),
    );
  }
}