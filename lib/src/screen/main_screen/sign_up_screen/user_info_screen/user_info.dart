import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info_body.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class UserInfo extends StatefulWidget{

  final Map<String, dynamic> _userData;

  UserInfo(this._userData);

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo> {

  ModelUserInfo _modelUserInfo = ModelUserInfo();

  @override
  void initState() {
    if (widget._userData['label'] != 'profile') {
      replaceDataToController();
    }
    else if (widget._userData['label'] == 'email' || widget._userData['phone']){
      getTokenByLogin();
    }
    super.initState();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void getTokenByLogin() async { /* Get Token To Make Authentication With Add User Info */
    await fetchData("user_token").then((_response) async {
      if (_response == null){
        var _res = await userLogin(
          widget._userData['email_Phone'], 
          widget._userData['passwords'], 
          widget._userData['label'] == "email" ? "/loginbyemail" : "/loginbyphone", 
          widget._userData['label'] 
        );
        await setData(_res, "user_token");
      }
    });
  }

  void replaceDataToController(){ /* Replace Data From Profile Screen After Push User Informtaion Screen */
    _modelUserInfo.controlFirstName.text = widget._userData['first_name'];
    _modelUserInfo.controlMidName.text = widget._userData['mid_name'];
    _modelUserInfo.controlLastName.text = widget._userData['last_name'];
    _modelUserInfo.genderLabel = widget._userData['gender'];
  }

  void submitProfile(BuildContext context) async { /* Submit Profile User */
    try {
      dialogLoading(context); /* Show Loading Process */
      var response = await uploadUserProfile(_modelUserInfo, '/userprofile'); /* Post Request Submit Profile */
      Navigator.pop(context); /* Close Loading Process */
      if (response != null && _modelUserInfo.token == null) { /* Set Profile Success */
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
  void changeGender(String gender) async {
    _modelUserInfo.genderLabel = gender;
    if (gender == "Male") _modelUserInfo.gender = "M";
    else _modelUserInfo.gender = "F";
    _modelUserInfo.genderLabel = gender;
    await Future.delayed(Duration(milliseconds: 100), () {
      setState(() { /* Unfocus All Field */
        _modelUserInfo.nodeFirstName.unfocus();
        _modelUserInfo.nodeMidName.unfocus();
        _modelUserInfo.nodeLastName.unfocus();
      });
    });
  }

  void onSubmit(BuildContext context) {
    if (_modelUserInfo.nodeFirstName.hasFocus) {
      FocusScope.of(context).requestFocus(_modelUserInfo.nodeFirstName);
    } else if (_modelUserInfo.nodeMidName.hasFocus) {
      FocusScope.of(context).requestFocus(_modelUserInfo.nodeMidName);
    } else {
      if (_modelUserInfo.gender != null) submitProfile(context);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0, color1, color2, 
        userInfoBodyWidget(context, _modelUserInfo, popScreen, onSubmit, changeGender, submitProfile)
      ),
    );
  }
}