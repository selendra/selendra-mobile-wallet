import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_change_pin.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_pin_screen/change_pin_body.dart';

class ChangePIN extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePIN> {

  ModelSignUp _model = ModelSignUp();

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String fieldName, String changed) {
    if (fieldName == "Old PIN") _model.controlOldPIN.text = changed;
    else if ( fieldName == "New PIN") _model.controlNewPIN.text = changed;
    else if ( fieldName == "Confirm PIN") _model.controlConfirmPIN.text = changed; 
  }

  void submitPIN(BuildContext context) async {
    dialogLoading(context); /* Show Loading Process */
    await changePIN(_model).then((_response) async {
      Navigator.pop(context); /* Close Loading Process */
      if (!_response.containsKey("error")) { /* Check Response Not Error */
        await dialog(context, Text("${_response['message']}"), Icon(Icons.done));
        Navigator.pop(context);
      }
      else await dialog(context, Text("${_response['error']['message']}"), Icon(Icons.done));
    });
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: changePinBodyWidget(context, _model, popScreen, onChanged, submitPIN),
    );
  }
}