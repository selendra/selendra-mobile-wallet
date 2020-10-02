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

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.myNumCount = 0;
    _modelForgotPassword.key = "phone";
    _modelForgotPassword.endpoint = "forget-password";
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

  // void timeCounter(Timer timer) async {
  //   print(timer.tick);
  //   // Assign Timer Number Counter To myNumCount Variable
  //   AppServices.myNumCount = timer.tick;
  //   // Cancel Timer When Rest Api Successfully
  //   if (_backend.response != null) timer.cancel();
  //   // Display TimeOut With SnackBar When Over 10 Second
  //   if (AppServices.myNumCount == 10) {
  //     Navigator.pop(context);
  //     _modelForgotPassword.globalKey.currentState.showSnackBar(SnackBar(content: Text('Connection timed out'),));
  //   }
  // }

  void requestCode(BuildContext context) async {

    // Show Dialog Loading
    dialogLoading(context);

    // Time Out Handler
    // AppServices.timerOutHandler(_backend.response, timeCounter);

    await Future.delayed(Duration(seconds: 9), (){});
    // Rest Api
    try{
      await _postRequest.forgetPassword(
        _modelForgotPassword, 
        _modelForgotPassword.key == "phone" ? "+855${_modelForgotPassword.controlPhoneNums.text}" : _modelForgotPassword.controllerEmail.text // Check User Request By Phone Number Or Email
      ).then((value) async {
        // Close Dialog Loading
        Navigator.pop(context);
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
          await dialog(context, Text(_backend.mapData['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor),));
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(_modelForgotPassword)));
        }
        // if (AppServices.myNumCount < 10) { 
          
        // }
      });
    } catch (err){
      await dialog(context, Text("Something gone wrong"), Text("Message"));
    }
  }

  void enableButton(bool enable) {
    setState(() {
      _modelForgotPassword.enable1 = enable;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _modelForgotPassword.globalKey,
      body: BodyScaffold(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: ForgetPasswordBody(
            forgetM: _modelForgotPassword, 
            tabBarSelectChanged: tabBarSelectChanged, 
            validatePhoneNumber: validatePhoneNumber, 
            validateEmail: validateEmail,
            onChanged: onChanged, 
            onSubmit: onSubmit,
            popScreen: Component.popScreen, 
            requestCode: requestCode
          ),
        ),
      )
    );
  }
}