import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/index.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> with SingleTickerProviderStateMixin{

  ModelSignUp _modelSignUp = ModelSignUp();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.noInternetConnection(_modelSignUp.globalKey);
    super.initState();
    _modelSignUp.tabController = new TabController(length: 2, vsync: this); /* Initialize Variable TabController */
  }

  void popScreen() { /* Pop Current Screen */
    Navigator.pop(context);
  }

  void navigatePage(BuildContext context) { /* Navigate To Second Sign Up */
    /* Prevent Submit On Smart Keyboard */
    if (_modelSignUp.enable == true) Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePassword(_modelSignUp)));
  }

  void onChanged(String onchanged) { /* Input Field Value Change */
    _modelSignUp.formState.currentState.validate();
  }

   // Submit From Keyboard
  void onSubmit() {
    if (_modelSignUp.nodeEmails.hasFocus || _modelSignUp.nodePhoneNums.hasFocus){
      FocusScope.of(context).requestFocus(_modelSignUp.nodePassword);
    } else if (_modelSignUp.nodePassword.hasFocus) {
      FocusScope.of(context).requestFocus(_modelSignUp.nodeConfirmPassword);
    } else { /* Prevent Submit On Smart Keyboard */ 
      if (_modelSignUp.enable == true) submit(context);
    }
  }

  String validateInput(String value){ /* Initial Validate */
    if (_modelSignUp.label == "email"){
      _modelSignUp.response = instanceValidate.validateEmails(value);
      setState(() {
        if (_modelSignUp.response == null) _modelSignUp.enable = true; 
        else _modelSignUp.enable = false;
      });
    } else {
      _modelSignUp.response = instanceValidate.validatePhone(value);
      setState(() {
        if (_modelSignUp.response == null) _modelSignUp.enable = true; 
        else _modelSignUp.enable = false;
      });
    }
    return _modelSignUp.response;
  }

  String validatePass1(String value){ /* Validate User Input And Enable Or Disable Button */
    if (_modelSignUp.nodePassword.hasFocus){
      _modelSignUp.responsePass1 = instanceValidate.validatePassword(value);
      validateAllField();
    }
    return _modelSignUp.responsePass1;
  }

  String validatePass2(String value) {
    if (_modelSignUp.nodeConfirmPassword.hasFocus){
      _modelSignUp.responsePass2 = instanceValidate.validatePassword(value);
      validateAllField();
    }
    return _modelSignUp.responsePass2;
  }

  void validateAllField(){

    if ( _modelSignUp.responsePass1 == null && _modelSignUp.responsePass2 == null ) {

      if (_modelSignUp.controlConfirmPassword.text == _modelSignUp.controlPassword.text) { 
        // Disable Not Match Text
        if (_modelSignUp.isMatch == false) _modelSignUp.isMatch = true;
        // If Not Match
        if (_modelSignUp.enable == false) _modelSignUp.enable = true;
      } 
      else {
        if (_modelSignUp.controlConfirmPassword.text != '' && _modelSignUp.controlPassword.text != ''){
          // Disable Button
          if (_modelSignUp.enable) _modelSignUp.enable = false;
          // Enable Not Match Text
          if (_modelSignUp.isMatch) _modelSignUp.isMatch = false;
        }
      }
    } else {
      // Disable Button
      if (_modelSignUp.enable) _modelSignUp.enable = false;
      // Enable Not Match Text
      if (_modelSignUp.isMatch == false) _modelSignUp.isMatch = true;
    }
    setState(() {});
  }

  // Show And Hide Passwords
  void showPassword(){
    if (_modelSignUp.nodePassword.hasFocus) {
      setState(() {
        if (_modelSignUp.hidePassword1 == false) _modelSignUp.hidePassword1 = true;
        else _modelSignUp.hidePassword1 = false;
      });
    } else if (_modelSignUp.nodeConfirmPassword.hasFocus){
      setState(() {
        if (_modelSignUp.hidePassword2 == false) _modelSignUp.hidePassword2 = true;
        else _modelSignUp.hidePassword2 = false;
      });
    } 
  }

  void tabBarSelectChanged(int index) {
    if ( index == 1 ){
      _modelSignUp.controlPhoneNums.clear();
      _modelSignUp.nodePhoneNums.unfocus();
      setState(() { /* Disable Button */
        _modelSignUp.enable = false;
      });
      _modelSignUp.label = "email";
    } else {
      _modelSignUp.controlEmails.clear();
      _modelSignUp.nodeEmails.unfocus();
      setState(() { /* Disable Button */
        _modelSignUp.enable = false;
      });
      _modelSignUp.label = "phone";
    }
    setState(() {});
  }

  /* -------------- Submit --------------- */

  // Navigate To Fill User Info
  void submit(BuildContext context) async { 

    // Display Dialog Loading
    dialogLoading(context);

    try{
      // Post Register By Email
      if (_modelSignUp.label == "email") { 
        await registerByEmail();
      }
      // Post Register By Phone Number
      else { 
        await registerByPhoneNumber();
      }
    } catch (e){
      await dialog(context, textAlignCenter(text: 'Something goes wrong !'), warningTitleDialog());
    }
  }

  // Register By Email
  Future<void> registerByEmail() async {

    await _postRequest.registerByEmail(_modelSignUp.controlEmails.text,  _modelSignUp.controlConfirmPassword.text).then((value) async {

      _backend.response = value;
      if (_backend.response != null) {
        // Navigator.pop(context);
        _backend.mapData = json.decode(_backend.response.body);
      }
      // Navigator Route
      await navigator();
    });
  }

  // Register By Phone Number
  Future<void> registerByPhoneNumber() async {

    await _postRequest.registerByPhone(_modelSignUp.controlPhoneNums.text, _modelSignUp.controlConfirmPassword.text).then((value) async {
      // if (AppServices.myNumCount < 10) {
        
      // }
      _backend.response = value;
      if (_backend.response != null) {
        // Navigator.pop(context);
        _backend.mapData = json.decode(_backend.response.body);
      }
      // Navigator Route
      await navigator();
    });
  }

  // Navigator Route
  Future<void> navigator() async {

    // Close Loading
    Navigator.pop(context);

    if (_backend.response.statusCode == 200){
      if (_backend.mapData['message'] == "Successfully registered!"){
        await dialog(
          context,
          textAlignCenter(text: "${_backend.mapData['message']}"),
          Icon(
            Icons.done_outline,
            color: hexaCodeToColor(AppColors.greenColor),
          ) 
        );

        await resendOtpCode().then((value) {
          _backend.mapData = json.decode(value.body);
          if(value.statusCode == 200){
            // Close Loading
            Navigator.pop(context); 
            Future.delayed(Duration(milliseconds: 100), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SmsCodeVerify(_modelSignUp.controlPhoneNums.text, _modelSignUp.controlConfirmPassword.text, _backend.mapData)
                )
              );
            });
          }
        });
      } else {
        await dialog(
          context,
          textAlignCenter(text: _backend.mapData['message']),
          Text("Message") 
        );
      }
    }

    // Remove All Focus Field After Click Button
    clearFocusInput();
  }

  // Send Message After Register
  Future<http.Response> resendOtpCode() async {
    return await _postRequest.resendCode(_modelSignUp.controlPhoneNums.text);
  }

  Future<void> clearFocusInput() async {
    await Future.delayed(Duration(milliseconds: 100), (){
      FocusScope.of(context).unfocus();
    });
  }
  
  build(BuildContext context) { /* User Sign Up Build */
    return Scaffold(
      key: _modelSignUp.globalKey,
      body: BodyScaffold(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: SignUpBody(
            modelSignUp: _modelSignUp,
            validateInput: validateInput,
            validatePassword: validatePass1,
            validateCfPassword: validatePass2,
            onChanged: onChanged,
            tabBarSelectChanged: tabBarSelectChanged,
            showPassword: showPassword,
            onSubmit: onSubmit,
            submit: submit,
          ),
        ),
      ),
    );
  }

}

