import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info_body.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class UserInfo extends StatefulWidget{

  final dynamic _model;

  UserInfo(this._model);

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo> {

  @override
  void initState() {
    if (widget._model.gender == null) widget._model.genderLabel = "Gender";
    getTokenByLogin();
    super.initState();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void getTokenByLogin() async { /* Get Token To Make Authentication With Add User Info */
    await fetchData("user_token").then((_response) async {
      if (_response == null){
        var _res = await userLogin(
          widget._model.label == "email" ? widget._model.controlEmails.text : "${widget._model.countryCode}${widget._model.controlPhoneNums.text}", 
          widget._model.controlSecureNumber.text, 
          widget._model.label == "email" ? "/loginbyemail" : "/loginbyphone", 
          widget._model.label
        );
        await setData(_res, "user_token");
      }
    });
  }

  void submitProfile(BuildContext context) async { /* Submit Profile User */
    try {
      dialogLoading(context); /* Show Loading Process */
      var response = await uploadUserProfile(widget._model, '/userprofile'); /* Post Request Submit Profile */
      Navigator.pop(context); /* Close Loading Process */
      if (response != null && widget._model.token == null) { /* Set Profile Success */
        await dialog(context, Text(response['message']), Icon(Icons.done_outline, color: getHexaColor(greenColor)));
        clearStorage();
        Future.delayed(Duration(microseconds: 500), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginFirstScreen()));
        });
      } else { /* Edit Profile Success */
        await dialog(context, Text(response['message']), Icon(Icons.done_outline, color: getHexaColor(greenColor)));
        Navigator.pop(context);
      }
    } catch (err) {}
  } 
  void changeGender(String gender) {
    widget._model.genderLabel = gender;
    if (gender == "Male") widget._model.gender = "M";
    else widget._model.gender = "F";
    widget._model.label = gender;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0, color1, color2, 
        userInfoBodyWidget(context, widget._model, popScreen, submitProfile, changeGender)
      ),
    );
  }
}