import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/create_password_screen/create_password_body.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';
import 'package:http/http.dart' as http;

class CreatePassword extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  CreatePassword(this._modelSignUp);

  @override
  State<StatefulWidget> createState() {
    return CreatePasswordState();
  }
}

class CreatePasswordState extends State<CreatePassword> {

  @override
  void initState() {
    super.initState();
  }
  var _response;

  void onChanged(String label, String changed) {

  }

  void popScreen() { /* Close Current Screen */
    Navigator.pop(context);
  }

  void navigatePage(BuildContext context) async { /* Navigate To Fill User Info */
    if (widget._modelSignUp.controlConfirmPasswords.text != "" && widget._modelSignUp.controlPasswords.text != "") { /* Password != Empty */
      if (widget._modelSignUp.controlConfirmPasswords.text != widget._modelSignUp.controlPasswords.text) { /* If Not Match */
        setState(() {
          widget._modelSignUp.isMatch = false; /* Pop Not Match Text Below Confrim Password Field */
        });
      } else {
        dialogLoading(context);
        if (widget._modelSignUp.label == "email") { /* Post Register By Email */
          _response = await widget._modelSignUp.bloc.registerMethod(
            context,
            widget._modelSignUp.controlEmails.text,
            widget._modelSignUp.controlPasswords.text,
            "/registerbyemail", "email"
          );
          if (_response == false) {
            Future.delayed(Duration(milliseconds: 100), (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo(widget._modelSignUp)));
            });
          }
        } else { /* Post Register By Phone Number */
          _response = await widget._modelSignUp.bloc.registerMethod(
            context,
            widget._modelSignUp.controlPhoneNums.text,
            widget._modelSignUp.controlPasswords.text,
            "/registerbyphone", "phone"
          );
          if (_response == true) {
            Future.delayed(Duration(milliseconds: 200), (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
            });
          }
        }
      }
    }
  }

  void changeFocus(BuildContext context, String value) {
    FocusScope.of(context).requestFocus(widget._modelSignUp.nodeConfirmPasswords);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0,
        color1, color2,
        createPasswordBodyWidget(context, widget._modelSignUp, onChanged, popScreen, changeFocus, navigatePage)
      )
    );
  }
}