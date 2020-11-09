import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/index.dart';

class ForgetPassword extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ForgetPasswordState();
  }
}

class ForgetPasswordState extends State<ForgetPassword> {
  
  ForgetModel _forgetM = ForgetModel();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.myNumCount = 0;
    _forgetM.key = "phone";
    _forgetM.endpoint = "forget-password";
    super.initState();
  }

  void onChanged(String changed){
    _forgetM.formState.currentState.validate();
    validateEnableButton();
  }

  void onSubmit(BuildContext context) {
    if (_forgetM.enable1) requestCode(); // If True Execute
  }

  String validatePhoneNumber(String value){
    if (_forgetM.nodePhoneNums.hasFocus){
      _forgetM.responsePhoneNumber = instanceValidate.validatePhone(value);
    }
    return _forgetM.responsePhoneNumber;
  }

  String validateEmail(String value){
    if (_forgetM.nodeEmail.hasFocus){
      _forgetM.responseEmail = instanceValidate.validateEmails(value);
    }
    return _forgetM.responseEmail;
  }

  void validateEnableButton() {
    if (_forgetM.key == "phone"){
      if (_forgetM.responsePhoneNumber == null) enableButton(true);
      else if (_forgetM.enable1) enableButton(false);
    } else {
      if (_forgetM.responseEmail == null) enableButton(true);
      else if (_forgetM.enable1) enableButton(false);
    }
  }

  void tabBarSelectChanged(int index){
    if (index == 0){
      _forgetM.controlPhoneNums.clear();
      _forgetM.nodePhoneNums.unfocus();

      _forgetM.key = "phone";
      _forgetM.endpoint = "forget-password";
    } else if (index == 1){
      _forgetM.controlPhoneNums.clear();
      _forgetM.nodePhoneNums.unfocus();

      _forgetM.key = "email";
      _forgetM.endpoint = "forget-password-by-email";
    }
    setState(() { });
  }

  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;
    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();
    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      Navigator.pop(context);
      _forgetM.globalKey.currentState.showSnackBar(SnackBar(content: Text('Connection timed out'),));
    }
  }

  void requestCode() async {

    FocusScope.of(context).unfocus();

    // Show Dialog Loading
    dialogLoading(context);

    // Time Out Handler
    AppServices.timerOutHandler(_backend.response, timeCounter);

    await Future.delayed(Duration(seconds: 9), (){});
    // Rest Api
    try{
      // Check User Request By Phone Number Or Email
      await _postRequest.forgetPassword(_forgetM, _forgetM.key == "phone" ? "+855${_forgetM.controlPhoneNums.text}" : _forgetM.controllerEmail.text).then((value) async {
        // // Close Dialog Loading
        // Navigator.pop(context);
        
        if (AppServices.myNumCount < 10) { 

          _backend.response = value;

          if (_backend.response != null) {
            // Navigator.pop(context);
            _backend.mapData = json.decode(_backend.response.body);
            await dialog(context, Text(_backend.mapData['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor),));
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(_forgetM)));
          }
        }
      });
    } on SocketException catch (e) {
      await Future.delayed(Duration(milliseconds: 300), () { });
      AppServices.openSnackBar(_forgetM.globalKey, e.message);
    } catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center), "Message");
    }
  }

  void enableButton(bool enable) {
    setState(() {
      _forgetM.enable1 = enable;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _forgetM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: ForgetPasswordBody(
            forgetM: _forgetM, 
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