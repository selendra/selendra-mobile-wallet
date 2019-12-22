import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/create_password_screen/create_password_body.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';

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
    print(widget._modelSignUp.controlEmails.text);
    super.initState();
  }

  void onChanged(String label, String changed) {

  }

  void popScreen() { /* Close Current Screen */
    Navigator.pop(context);
  } 

  void navigatePage(BuildContext context) { /* Navigate To Fill User Info */
    if (widget._modelSignUp.controlConfirmPasswords.text != "" && widget._modelSignUp.controlPasswords.text != "") { /* Password != Empty */
      if (widget._modelSignUp.controlConfirmPasswords.text != widget._modelSignUp.controlPasswords.text) {
        setState(() {
          widget._modelSignUp.isMatch = true; /* Pop Not Match Text Below Confrim Password Field */
        });
      } else Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo(widget._modelSignUp)));
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