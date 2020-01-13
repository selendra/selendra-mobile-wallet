import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/create_password_screen/create_password_body.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';

class CreatePassword extends StatefulWidget {
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

  void onChanged(String label, String changed) {}

  void popScreen() {
    /* Close Current Screen */
    Navigator.pop(context);
  }

  void navigatePage(BuildContext context) async {
    /* Navigate To Fill User Info */
    if (widget._modelSignUp.controlConfirmSecureNumber.text != "" &&
        widget._modelSignUp.controlSecureNumber.text != "") {
      /* Password != Empty */
      if (widget._modelSignUp.controlConfirmSecureNumber.text !=
          widget._modelSignUp.controlSecureNumber.text) {
        /* If Not Match */
        setState(() {
          widget._modelSignUp.isMatch = false; /* Pop Not Match Text Below Confrim Password Field */
        });
      } else {
        dialogLoading(context);
        if (widget._modelSignUp.label == "email") { /* Post Register By Email */
          _response = await widget._modelSignUp.bloc.registerMethod(
            context,
            widget._modelSignUp.controlEmails.text,
            widget._modelSignUp.controlSecureNumber.text,
            "/registerbyemail",
            "email"
          );
          if (_response == true) {
            Future.delayed(Duration(milliseconds: 100), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfo(widget._modelSignUp)
                )
              );
            });
          }
        } else {
          /* Post Register By Phone Number */
          _response = await widget._modelSignUp.bloc.registerMethod(
              context,
              "${widget._modelSignUp.countryCode}${widget._modelSignUp.controlPhoneNums.text}",
              widget._modelSignUp.controlConfirmSecureNumber.text,
              "/registerbyphone",
              "phone");
          if (_response == true) {
            /* Change To True When your testing done */
            Future.delayed(Duration(milliseconds: 100), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => UserInfo(widget._modelSignUp)
                )
              );
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SmsCode(widget._modelSignUp)));
            });
          }
        }
      }
    }
  }

  void changeFocus(BuildContext context, String value) {
    FocusScope.of(context)
        .requestFocus(widget._modelSignUp.nodeConfirmSecureNumber);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0,16.0, 0,
        color1, color2,
        createPasswordBodyWidget(context, widget._modelSignUp, onChanged,popScreen, changeFocus, navigatePage)
      )
    );
  }
}
