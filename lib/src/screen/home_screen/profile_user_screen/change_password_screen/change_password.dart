import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_password_screen/change_password_body.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePassword> {
  ModelSignUp _model = ModelSignUp();

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String fieldName, String changed) {
    if (fieldName == "Old Password")
      _model.controlOldSecureNumber.text = changed;
    else if (fieldName == "New Password")
      _model.controlSecureNumber.text = changed;
    else if (fieldName == "Confirm Password")
      _model.controlConfirmSecureNumber.text = changed;
  }

  void submitPIN(BuildContext context) async {
    dialogLoading(context); /* Show Loading Process */
    await changePassword(_model).then((_response) async {
      Navigator.pop(context); /* Close Loading Process */
      if (!_response.containsKey("error")) {
        /* Check Response Not Error */
        await dialog(
          context, Text("${_response['message']}"), Icon(Icons.done));
        Navigator.pop(context);
      } else
        await dialog(context, Text("${_response['error']['message']}"),Icon(Icons.warning));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: changePasswordBodyWidget(context, _model, popScreen, onChanged, submitPIN),
    );
  }
}
