import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_change_password.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_password_screen/change_password_body.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePassword> {
  ModelChangePassword _modelChangePassword = ModelChangePassword();

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String fieldName, String changed) {
    if (fieldName == "Old Password")
      _modelChangePassword.controlOldPassword.text = changed;
    else if (fieldName == "New Password")
      _modelChangePassword.controlNewPassword.text = changed;
    else if (fieldName == "Confirm Password")
      _modelChangePassword.controlConfirmPassword.text = changed;
  }

  void submitPIN(BuildContext context) async {
    dialogLoading(context); /* Show Loading Process */
    await changePassword(_modelChangePassword).then((_response) async {
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
      body: changePasswordBodyWidget(context, _modelChangePassword, popScreen, onChanged, submitPIN),
    );
  }
}
