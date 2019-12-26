import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
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

  void submitProfile(BuildContext context) async {
    dialogLoading(context);
    try {
      var response = await uploadUserProfile(widget._modelSignUp, '/userprofile');
      Navigator.pop(context);
      if (response != null) {
        await dialog(context, Text(response['message']), Icon(Icons.done_outline, color: getHexaColor(greenColor)));
        Future.delayed(Duration(microseconds: 500), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpFirst()));
        });
      }
    } catch (err) {}
  } 
  void changeGender(String gender) {
    if (gender == "Male") widget._modelSignUp.gender = "M";
    else widget._modelSignUp.gender = "F";
    widget._modelSignUp.label = gender;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0, color1, color2, 
        userInfoBodyWidget(context, widget._modelSignUp, popScreen, submitProfile, changeGender)
      ),
    );
  }
}