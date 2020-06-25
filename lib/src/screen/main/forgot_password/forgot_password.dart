import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/index.dart';

class ForgotPassword extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  
  ModelForgotPassword _modelForgotPassword = ModelForgotPassword();

  PostRequest _postRequest = PostRequest();

  @override
  void initState() {
    _modelForgotPassword.key = "phone";
    _modelForgotPassword.endpoint = "forget-password";
    AppServices.noInternetConnection(_modelForgotPassword.globalKey);
    super.initState();
  }

  void onChanged(String changed){
    _modelForgotPassword.formState.currentState.validate();
    validateEnableButton();
  }

  void onSubmit(BuildContext context) {
    if (_modelForgotPassword.enable1) requestCode(context); // If True Execute
  }

  String validatePhoneNumber(String value){
    if (_modelForgotPassword.nodePhoneNums.hasFocus){
      _modelForgotPassword.responsePhoneNumber = instanceValidate.validatePhone(value);
    }
    return _modelForgotPassword.responsePhoneNumber;
  }

  String validateEmail(String value){
    if (_modelForgotPassword.nodeEmail.hasFocus){
      _modelForgotPassword.responseEmail = instanceValidate.validateEmails(value);
    }
    return _modelForgotPassword.responseEmail;
  }

  void validateEnableButton() {
    if (_modelForgotPassword.key == "phone"){
      if (_modelForgotPassword.responsePhoneNumber == null) enableButton(true);
      else if (_modelForgotPassword.enable1) enableButton(false);
    } else {
      if (_modelForgotPassword.responseEmail == null) enableButton(true);
      else if (_modelForgotPassword.enable1) enableButton(false);
    }
  }

  void tabBarSelectChanged(int index){
    if (index == 0){
      _modelForgotPassword.controlPhoneNums.clear();
      _modelForgotPassword.nodePhoneNums.unfocus();

      _modelForgotPassword.key = "phone";
      _modelForgotPassword.endpoint = "forget-password";
    } else if (index == 1){
      _modelForgotPassword.controlPhoneNums.clear();
      _modelForgotPassword.nodePhoneNums.unfocus();

      _modelForgotPassword.key = "email";
      _modelForgotPassword.endpoint = "forget-password-by-email";
    }
    setState(() { });
  }

  void requestCode(BuildContext context) async {
    dialogLoading(context);
    await _postRequest.forgetPassword(
      _modelForgotPassword, 
      _modelForgotPassword.key == "phone" ? "+855${_modelForgotPassword.controlPhoneNums.text}" : _modelForgotPassword.controllerEmail.text // Check User Request By Phone Number Or Email
    ).then((_response) async {
      Navigator.pop(context);
      await dialog(context, Text(_response['message']), Icon(Icons.done_outline, color: getHexaColor(AppColors.greenColor),));
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(_modelForgotPassword)));
    });
  }

  void enableButton(bool enable) {
    setState(() {
      _modelForgotPassword.enable1 = enable;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _modelForgotPassword.globalKey,
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: scaffoldBGDecoration(
          child: forgetPasswordBody(
            context, 
            _modelForgotPassword, 
            tabBarSelectChanged, validatePhoneNumber, validateEmail,
            onChanged, onSubmit,
            MainComponent.popScreen, requestCode
          )
        ),
      ),
    );
  }
}