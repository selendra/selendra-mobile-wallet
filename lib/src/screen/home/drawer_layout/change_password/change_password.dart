import 'package:wallet_apps/index.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePassword> {

  ModelChangePassword _modelChangePassword = ModelChangePassword();

  @override
  initState(){
    AppServices.noInternetConnection(_modelChangePassword.globalKey);
    super.initState();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String changed) {
    _modelChangePassword.formStateChangePassword.currentState.validate();
  }

  void onSubmit(BuildContext context){
    if (_modelChangePassword.nodeOldPassword.hasFocus) {
      FocusScope.of(context).requestFocus(_modelChangePassword.nodeNewPassword);
    } else if (_modelChangePassword.nodeNewPassword.hasFocus){
      FocusScope.of(context).requestFocus(_modelChangePassword.nodeConfirmPassword);
    } else {
      if (_modelChangePassword.enable == true) submitPassword(context);
    }
  }

  String validateOldPass(String value){
    if(_modelChangePassword.nodeOldPassword.hasFocus){
      _modelChangePassword.responseOldPass = instanceValidate.validatePassword(value);
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseOldPass;
  } 

  String validateNewPass(String value){
    if (_modelChangePassword.nodeNewPassword.hasFocus){
      _modelChangePassword.responseNewPass = instanceValidate.validatePassword(value);
      if (_modelChangePassword.responseNewPass == null) {
        _modelChangePassword.responseConfirm = newPasswordIsmatch();
      } 
      else if (_modelChangePassword.responseConfirm == "Confirm password does not match"){ // Remove Not Match Error When New Pass Error
        _modelChangePassword.responseConfirm = null;
      }
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseNewPass;
  } 

  String validateConfirmPass(String value){
    if(_modelChangePassword.nodeConfirmPassword.hasFocus){
      _modelChangePassword.responseConfirm = instanceValidate.validatePassword(value);
      if (_modelChangePassword.responseConfirm == null) _modelChangePassword.responseConfirm = confirmPasswordIsMatch();
      validateAllFieldNotEmpty();
    }
    return _modelChangePassword.responseConfirm;
  } 

  void validateAllFieldNotEmpty(){ /* Enable And Disable Button */
    if (
      _modelChangePassword.controlOldPassword.text.length >= 5 &&
      _modelChangePassword.controlNewPassword.text.length >= 5 &&
      _modelChangePassword.controlConfirmPassword.text.length >= 5 
    ) validateAllFieldNoError();
    else if (_modelChangePassword.enable == true) enableButton(false);
  }

  void validateAllFieldNoError(){
    if (
      _modelChangePassword.responseOldPass == null &&
      _modelChangePassword.responseNewPass == null &&
      _modelChangePassword.responseConfirm == null 
    ) enableButton(true); 
    else if (_modelChangePassword.enable == true) enableButton(false);
  }

  String newPasswordIsmatch(){
    if (_modelChangePassword.controlConfirmPassword.text.length >= 5){
      if (_modelChangePassword.controlNewPassword.text == _modelChangePassword.controlConfirmPassword.text){
        enableButton(true);
        _modelChangePassword.responseConfirm = null;
      } else {
        if (_modelChangePassword.enable == true) enableButton(false);
        _modelChangePassword.responseConfirm = "Confirm password does not match";
      }
    }
    return _modelChangePassword.responseConfirm;
  }

  String confirmPasswordIsMatch(){
    if (_modelChangePassword.controlNewPassword.text.length >= 5){
      if (_modelChangePassword.controlNewPassword.text == _modelChangePassword.controlConfirmPassword.text){
        enableButton(true);
        _modelChangePassword.responseConfirm = null;
      } else {
        if (_modelChangePassword.enable == true) enableButton(false);
        _modelChangePassword.responseConfirm = "Confirm password does not match";
      }
    }
    return _modelChangePassword.responseConfirm;
  }

  void enableButton(bool enable){
    setState(() => _modelChangePassword.enable = enable);
  }

  void removeAllFocus() {
    _modelChangePassword.nodeOldPassword.unfocus( );
    _modelChangePassword.nodeNewPassword.unfocus();
    _modelChangePassword.nodeConfirmPassword.unfocus();
  }

  void submitPassword(BuildContext context) async {
    dialogLoading(context); /* Show Loading Process */
    await changePassword(_modelChangePassword).then((_response) async {
      Navigator.pop(context); /* Close Loading Process */
      if (!_response.containsKey("error")) { /* Check Response Not Error */
        await dialog(
          context, 
          Text("${_response['message']}"), 
          Icon(Icons.done_outline, color: getHexaColor(AppColors.greenColor))
        );
        Navigator.pop(context);
      } else
        await dialog(context, Text("${_response['error']['message']}"), textMessage());
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
      key: _modelChangePassword.globalKey,
      body: scaffoldBGDecoration(
        child: changePasswordBody(
          context, 
          _modelChangePassword, 
          validateOldPass, validateNewPass, validateConfirmPass,
          onSubmit, onChanged, 
          submitPassword, popScreen
        ),
      )
    );
  }
}
