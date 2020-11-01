import 'package:wallet_apps/index.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePINState();
  }
}

class ChangePINState extends State<ChangePassword> {

  ModelChangePassword _changePasswordM = ModelChangePassword();

  PostRequest _postRequest = PostRequest();

  @override
  initState(){
    AppServices.noInternetConnection(_changePasswordM.globalKey);
    super.initState();
  }
  
  @override
  void dispose(){
    removeAllFocus();
    _changePasswordM.controlOldPassword.clear();
    _changePasswordM.controlNewPassword.clear();
    _changePasswordM.controlConfirmPassword.clear();
    super.dispose();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void onChanged(String changed) {
    _changePasswordM.formStateChangePassword.currentState.validate();
  }

  void onSubmit(BuildContext context){
    if (_changePasswordM.nodeOldPassword.hasFocus) {
      FocusScope.of(context).requestFocus(_changePasswordM.nodeNewPassword);
    } else if (_changePasswordM.nodeNewPassword.hasFocus){
      FocusScope.of(context).requestFocus(_changePasswordM.nodeConfirmPassword);
    } else {
      if (_changePasswordM.enable == true) submitPassword();
    }
  }

  String validateOldPass(String value){
    if(_changePasswordM.nodeOldPassword.hasFocus){
      _changePasswordM.responseOldPass = instanceValidate.validatePassword(value);
      validateAllFieldNotEmpty();
    }
    return _changePasswordM.responseOldPass;
  } 

  String validateNewPass(String value){
    if (_changePasswordM.nodeNewPassword.hasFocus){
      _changePasswordM.responseNewPass = instanceValidate.validatePassword(value);
      if (_changePasswordM.responseNewPass == null) {
        _changePasswordM.responseConfirm = newPasswordIsmatch();
      } 
      else if (_changePasswordM.responseConfirm == "Confirm password does not match"){ // Remove Not Match Error When New Pass Error
        _changePasswordM.responseConfirm = null;
      }
      validateAllFieldNotEmpty();
    }
    return _changePasswordM.responseNewPass;
  } 

  String validateConfirmPass(String value){
    if(_changePasswordM.nodeConfirmPassword.hasFocus){
      _changePasswordM.responseConfirm = instanceValidate.validatePassword(value);
      if (_changePasswordM.responseConfirm == null) _changePasswordM.responseConfirm = confirmPasswordIsMatch();
      validateAllFieldNotEmpty();
    }
    return _changePasswordM.responseConfirm;
  } 

  void validateAllFieldNotEmpty(){ /* Enable And Disable Button */
    if (
      _changePasswordM.controlOldPassword.text.length >= 5 &&
      _changePasswordM.controlNewPassword.text.length >= 5 &&
      _changePasswordM.controlConfirmPassword.text.length >= 5 
    ) validateAllFieldNoError();
    else if (_changePasswordM.enable == true) enableButton(false);
  }

  void validateAllFieldNoError(){
    if (
      _changePasswordM.responseOldPass == null &&
      _changePasswordM.responseNewPass == null &&
      _changePasswordM.responseConfirm == null 
    ) enableButton(true); 
    else if (_changePasswordM.enable == true) enableButton(false);
  }

  String newPasswordIsmatch(){
    if (_changePasswordM.controlConfirmPassword.text.length >= 5){
      if (_changePasswordM.controlNewPassword.text == _changePasswordM.controlConfirmPassword.text){
        enableButton(true);
        _changePasswordM.responseConfirm = null;
      } else {
        if (_changePasswordM.enable == true) enableButton(false);
        _changePasswordM.responseConfirm = "Confirm password does not match";
      }
    }
    return _changePasswordM.responseConfirm;
  }

  String confirmPasswordIsMatch(){
    if (_changePasswordM.controlNewPassword.text.length >= 5){
      if (_changePasswordM.controlNewPassword.text == _changePasswordM.controlConfirmPassword.text){
        enableButton(true);
        _changePasswordM.responseConfirm = null;
      } else {
        if (_changePasswordM.enable == true) enableButton(false);
        _changePasswordM.responseConfirm = "Confirm password does not match";
      }
    }
    return _changePasswordM.responseConfirm;
  }

  void enableButton(bool enable){
    setState(() => _changePasswordM.enable = enable);
  }

  void removeAllFocus() {
    _changePasswordM.nodeOldPassword.unfocus( );
    _changePasswordM.nodeNewPassword.unfocus();
    _changePasswordM.nodeConfirmPassword.unfocus();
  }

  void submitPassword() async {
    dialogLoading(context); /* Show Loading Process */
    try {
      await _postRequest.changePassword(_changePasswordM).then((_response) async {
        Navigator.pop(context); /* Close Loading Process */
        if (!_response.containsKey("error")) { /* Check Response Not Error */
          await dialog(
            context, 
            Text("${_response['message']}"), 
            Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor))
          );
          Navigator.pop(context);
        } else
          await dialog(context, Text("${_response['error']['message']}"), textMessage());
      });
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message")); 
      snackBar(_changePasswordM.globalKey, e.message.toString());
    } catch (e) {
      await dialog(context, Text(e.message.toString()), Text("Message")); 
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _changePasswordM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: ChangePasswordBody(
          model: _changePasswordM, 
          validateOldPass: validateOldPass, 
          validateNewPass: validateNewPass, 
          validateConfirmPass: validateConfirmPass,
          onSubmitted: onSubmit, 
          onChanged: onChanged, 
          submitPassword: submitPassword, 
          popScreen: popScreen
        ),
      )
    );
  }
}
