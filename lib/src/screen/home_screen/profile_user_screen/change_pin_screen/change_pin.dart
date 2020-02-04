import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_change_pin.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_pin_screen/change_pin_body.dart';

class ChangePIN extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePIN> {

  ModelChangePin _modelChangePin = ModelChangePin();

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String fieldName, String changed) {
    if (fieldName == "Old PIN")
      _modelChangePin.controllerOldPin.text = changed;
    else if (fieldName == "New PIN")
      _modelChangePin.controllerNewPin.text = changed;
    else if (fieldName == "Confirm PIN")
      _modelChangePin.controllerConfirmPin.text = changed;
  }

  void submitPIN(BuildContext context) async {
    dialogLoading(context); /* Show Loading Process */
    await changePIN(_modelChangePin).then((_response) async {
      Navigator.pop(context); /* Close Loading Process */
      if (!_response.containsKey("error")) { /* Check Response Not Error */
        await dialog( context, Text("${_response['message']}"), Icon(Icons.done));
        Navigator.pop(context);
      } else
        await dialog(context, Text("${_response['error']['message']}"), Icon(Icons.warning));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: changePinBodyWidget(context, _modelChangePin, popScreen, onChanged, submitPIN),
    );
  }
}
