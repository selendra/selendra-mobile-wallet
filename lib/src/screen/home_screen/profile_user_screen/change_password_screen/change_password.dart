import 'package:flutter/material.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_change_password.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/change_password_screen/change_password_body.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

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

  void onChanged(String changed) {
    _modelChangePassword.formStateChangePassword.currentState.validate();
  }

  void onSubmit(BuildContext context){

  }

  String validateOldPass(String value){
    if(_modelChangePassword.nodeOldPassword.hasFocus){
      _modelChangePassword.responseOldPass = instanceValidate.validatePassword(value);
    }
    return _modelChangePassword.responseOldPass;
  } 

  String validateNewPass(String value){
    if (_modelChangePassword.nodeNewPassword.hasFocus){
      _modelChangePassword.responseNewPass = instanceValidate.validatePassword(value);
    }
    return _modelChangePassword.responseNewPass;
  } 

  String validateConfirmPass(String value){
    if(_modelChangePassword.nodeConfirmPassword.hasFocus){
      _modelChangePassword.responseConfirm = instanceValidate.validatePassword(value);
    }
    return _modelChangePassword.responseConfirm;
  } 

  void removeAllFocus() {
    _modelChangePassword.nodeOldPassword.unfocus( );
    _modelChangePassword.nodeNewPassword.unfocus();
    _modelChangePassword.nodeConfirmPassword.unfocus();
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

  @override
  void dispose(){
    removeAllFocus();
    _modelChangePassword.controlOldPassword.clear();
    _modelChangePassword.controlNewPassword.clear();
    _modelChangePassword.controlConfirmPassword.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: changePasswordBodyWidget(context, _modelChangePassword, popScreen, onChanged, submitPIN),
    );
  }
}
