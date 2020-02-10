import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_change_pin.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_pin_screen/change_pin_body.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

class ChangePIN extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePIN> {
  
  ModelChangePin _modelChangePin = ModelChangePin();

  void onChanged(String changed) {
    _modelChangePin.formStateChangePin.currentState.validate();
  }

  String validateOldPin(String value) {
    if (_modelChangePin.nodeOldPin.hasFocus) {
      _modelChangePin.responseOldPin = instanceValidate.validateChangePin(value);
      enableButton(); /* Check All Field To Enable Button */
      if (_modelChangePin.responseOldPin != null)
        _modelChangePin.responseOldPin += "old pin";
    }
    return _modelChangePin.responseOldPin;
  }

  String validateNewPin(String value) {
    if (_modelChangePin.nodeNewPin.hasFocus) {
      _modelChangePin.responseNewPin = instanceValidate.validateChangePin(value);
      enableButton(); /* Check All Field To Enable Button */
      if (_modelChangePin.responseNewPin != null)
        _modelChangePin.responseNewPin += "new pin";
    }
    return _modelChangePin.responseNewPin;
  }

  String validateConfirmPin(String value) {
    if (_modelChangePin.nodeConfirmPin.hasFocus) {
      _modelChangePin.responseConfirmPin = instanceValidate.validateChangePin(value);
      enableButton(); /* Check All Field To Enable Button */
      if (_modelChangePin.responseConfirmPin != null)
        _modelChangePin.responseConfirmPin += "confirm pin";
    }
    return _modelChangePin.responseConfirmPin;
  }

  void onSubmit(BuildContext context) async {
    if (_modelChangePin.nodeOldPin.hasFocus){
      _modelChangePin.nodeOldPin.unfocus();
      FocusScope.of(context).requestFocus(_modelChangePin.nodeNewPin);
    } else if (_modelChangePin.nodeNewPin.hasFocus){
      _modelChangePin.nodeNewPin.unfocus();
      FocusScope.of(context).requestFocus(_modelChangePin.nodeConfirmPin);
    } else if (_modelChangePin.enable == true) submitPIN(context);
  }

  void enableButton() { /* Validate To Enable Button */
    if (
      _modelChangePin.controllerOldPin.text != "" &&
      _modelChangePin.controllerNewPin.text != "" &&
      _modelChangePin.controllerConfirmPin.text != ""
    ) setState(() => _modelChangePin.enable = true);
    else if (_modelChangePin.enable == true) setState(() => _modelChangePin.enable = false);
  }

  void submitPIN(BuildContext context) async { /* Submit Pin */
    removeAllFocus();
    dialogLoading(context); /* Show Loading Process */
    await changePIN(_modelChangePin).then((_response) async {
      Navigator.pop(context); /* Close Loading Process */
      if (!_response.containsKey("error")) { /* Check Response Not Error */
        await dialog(
          context, 
          Text("${_response['message']}"), 
          Icon(Icons.done)
        );
        Navigator.pop(context);
      } else {
        await dialog(
          context, 
          Text("${_response['error']['message']}"),
          Icon(Icons.warning)
        );
      }
    });
  }

  void removeAllFocus(){
    _modelChangePin.nodeOldPin.unfocus();
    _modelChangePin.nodeNewPin.unfocus();
    _modelChangePin.nodeConfirmPin.unfocus();
  }

  void popScreen() { /* Close Screen */
    Navigator.pop(context);
  }

  void dispose() {
    removeAllFocus();
    _modelChangePin.controllerOldPin.clear();
    _modelChangePin.controllerNewPin.clear();
    _modelChangePin.controllerConfirmPin.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: changePinBodyWidget(
        context,
        _modelChangePin,
        validateOldPin,
        validateNewPin,
        validateConfirmPin,
        onChanged,
        onSubmit,
        submitPIN,
        popScreen
      ),
    );
  }
}
