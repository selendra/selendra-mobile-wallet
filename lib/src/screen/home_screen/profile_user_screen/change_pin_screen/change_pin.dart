import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_change_pin.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_pin_screen/change_pin_body.dart';

class ChangePIN extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePIN> {

  ModelChangePin _modelChangePin = ModelChangePin();

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String fieldName, String changed) {
    if (fieldName == "Old PIN") _modelChangePin.controllerOldPin.text = changed;
    else if ( fieldName == "New PIN") _modelChangePin.controllerNewPin.text = changed;
    else if ( fieldName == "Confirm PIN") _modelChangePin.controllerConfirmPin.text = changed; 
  }

  void submitPin(BuildContext context) {

  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: changePinBodyWidget(context, _modelChangePin, popScreen, onChanged, submitPin),
    );
  }
}