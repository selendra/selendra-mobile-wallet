import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/index.dart';

class ForgetPassword extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ForgetPasswordState();
  }
}

class ForgetPasswordState extends State<ForgetPassword> {
  
  ForgetModel _forgetModel = ForgetModel();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.myNumCount = 0;
    _forgetModel.key = "phone";
    _forgetModel.endpoint = "forget-password";
    super.initState();
  }

  void onChanged(String changed){
    _forgetModel.formState.currentState.validate();
    validateEnableButton();
  }

  void onSubmit(BuildContext context) {
    if (_forgetModel.enable1) requestCode(context); // If True Execute
  }

  String validatePhoneNumber(String value){
    if (_forgetModel.nodePhoneNums.hasFocus){
      _forgetModel.responsePhoneNumber = instanceValidate.validatePhone(value);
    }
    return _forgetModel.responsePhoneNumber;
  }

  String validateEmail(String value){
    if (_forgetModel.nodeEmail.hasFocus){
      _forgetModel.responseEmail = instanceValidate.validateEmails(value);
    }
    return _forgetModel.responseEmail;
  }

  void validateEnableButton() {
    if (_forgetModel.key == "phone"){
      if (_forgetModel.responsePhoneNumber == null) enableButton(true);
      else if (_forgetModel.enable1) enableButton(false);
    } else {
      if (_forgetModel.responseEmail == null) enableButton(true);
      else if (_forgetModel.enable1) enableButton(false);
    }
  }

  void tabBarSelectChanged(int index){
    if (index == 0){
      _forgetModel.controlPhoneNums.clear();
      _forgetModel.nodePhoneNums.unfocus();

      _forgetModel.key = "phone";
      _forgetModel.endpoint = "forget-password";
    } else if (index == 1){
      _forgetModel.controlPhoneNums.clear();
      _forgetModel.nodePhoneNums.unfocus();

      _forgetModel.key = "email";
      _forgetModel.endpoint = "forget-password-by-email";
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
  //     _forgetModel.globalKey.currentState.showSnackBar(SnackBar(content: Text('Connection timed out'),));
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
        _forgetModel, 
        _forgetModel.key == "phone" ? "+855${_forgetModel.controlPhoneNums.text}" : _forgetModel.controllerEmail.text // Check User Request By Phone Number Or Email
      ).then((value) async {
        // Close Dialog Loading
        Navigator.pop(context);
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
          await dialog(context, Text(_backend.mapData['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor),));
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(_forgetModel)));
        }
        // if (AppServices.myNumCount < 10) { 
          
        // }
      });
    } on SocketException catch (e){
      await dialog(context, Text("${e.message}"), Text("Message"));
    }
  }

  void enableButton(bool enable) {
    setState(() {
      _forgetModel.enable1 = enable;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _forgetModel.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: ForgetPasswordBody(
            forgetM: _forgetModel, 
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