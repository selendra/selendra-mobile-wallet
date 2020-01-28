import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_forgot_pass.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/reset_password_screen/reset_password_body.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';

class ResetPassword extends StatefulWidget{

  final ModelForgotPassword _modelForgotPassword;

  ResetPassword(this._modelForgotPassword);

  @override
  State<StatefulWidget> createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {

  void popScreen() {
    Navigator.pop(context);
  }

  void submitResetPassword(BuildContext context) async {
    dialogLoading(context);
    await resetPass(widget._modelForgotPassword).then((_response) async {
      Navigator.pop(context);
      await dialog(context, Text(_response['message']), Icon(Icons.done));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginFirstScreen()), ModalRoute.withName('/'));
    });
  }

  void onChanged(String label, String changed){

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0,
        color1, color2,
        resetPasswordBody(context, widget._modelForgotPassword, onChanged, submitResetPassword , popScreen)
      ),
    );
  }
}