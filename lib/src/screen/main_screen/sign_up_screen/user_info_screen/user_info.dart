import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_first_screen/signup_first.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info_body.dart';

class UserInfo extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  UserInfo(this._modelSignUp);

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo> {

  void popScreen() {
    Navigator.pop(context);
  }

  void submit(BuildContext context) async {
    dialogLoading(context);
    if (widget._modelSignUp.label == "email") {
      await widget._modelSignUp.bloc.registerMethod(
        context,
        widget._modelSignUp.controlEmails.text,
        widget._modelSignUp.controlPasswords.text,
        "registerbyemail", "email"
      );
    } else {
      await widget._modelSignUp.bloc.registerMethod(
        context,
        widget._modelSignUp.controlPhoneNums.text,
        widget._modelSignUp.controlPasswords.text,
        "registerbyphone", "phone"
      );
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpFirst()));
  } 

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0, color1, color2, 
        userInfoBodyWidget(context, widget._modelSignUp, popScreen, submit)
      ),
    );
  }
}