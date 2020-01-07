import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info_body.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class UserInfo extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  UserInfo(this._modelSignUp);

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo> {

  @override
  void initState() {
    getTokenByLogin();
    super.initState();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void getTokenByLogin() async { /* Get Token To Make Authentication With Add User Info */
    var _response = await userLogin(
      widget._modelSignUp.label == "email" ? widget._modelSignUp.controlEmails.text : "${widget._modelSignUp.countryCode}${widget._modelSignUp.controlPhoneNums.text}", 
      widget._modelSignUp.controlConfirmPasswords.text, 
      widget._modelSignUp.label == "email" ? "/loginbyemail" : "/loginbyphone", 
      widget._modelSignUp.label
    );
    await setData(_response, "user_token");
  }

  void submitProfile(BuildContext context) async { /* Submit Profile User */
    try {
      dialogLoading(context); /* Show Loading Process */
      var response = await uploadUserProfile(widget._modelSignUp, '/userprofile'); /* Post Request Submit Profile */
      Navigator.pop(context); /* Close Loading Process */
      if (response != null) {
        await dialog(context, Text(response['message']), Icon(Icons.done_outline, color: getHexaColor(greenColor)));
        clearStorage();
        Future.delayed(Duration(microseconds: 500), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginFirstScreen()));
        });
      }
    } catch (err) {}
  } 
  void changeGender(String gender) {
    widget._modelSignUp.genderLabel = gender;
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