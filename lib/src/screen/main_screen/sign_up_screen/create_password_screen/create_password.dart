import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/create_password_screen/create_password_body.dart';

class CreatePassword extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  CreatePassword(this._modelSignUp);

  @override
  State<StatefulWidget> createState() {
    return CreatePasswordState();
  }
}

class CreatePasswordState extends State<CreatePassword> {

  void onChanged(String label, String changed) {

  }

  void popScreen() {
    Navigator.pop(context);
  }

  void navigatePage() {
    // Navigator.push(context, Mater)
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0,
        color1, color2,
        createPasswordBodyWidget(context, widget._modelSignUp, onChanged, popScreen, navigatePage)
      )
    );
  }
}