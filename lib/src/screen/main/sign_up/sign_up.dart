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

  ModelSignUp _signUpM = ModelSignUp();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.noInternetConnection(_signUpM.globalKey);
    super.initState();
    _signUpM.tabController = new TabController(length: 2, vsync: this); /* Initialize Variable TabController */
  }

  void popScreen() { /* Pop Current Screen */
    Navigator.pop(context);
  }

  void onChanged(String onchanged) { /* Input Field Value Change */
    _signUpM.formState.currentState.validate();
  }

   // Submit From Keyboard
  void onSubmit() {
    if (_signUpM.nodeEmails.hasFocus || _signUpM.nodePhoneNums.hasFocus){
      FocusScope.of(context).requestFocus(_signUpM.nodePassword);
    } else if (_signUpM.nodePassword.hasFocus) {
      FocusScope.of(context).requestFocus(_signUpM.nodeConfirmPassword);
    } else { /* Prevent Submit On Smart Keyboard */ 
      if (_signUpM.enable == true) submit();
    }
  }

  String validateInput(String value){ /* Initial Validate */

    if (_signUpM.nodePhoneNums.hasFocus){
      _signUpM.responseInput = instanceValidate.validatePhone(value);
      validateAllField();
    } else if (_signUpM.nodeEmails.hasFocus){
      _signUpM.responseInput = instanceValidate.validateEmails(value);
      validateAllField();
    }
    return _signUpM.responseInput;
  }

  String validatePass1(String value){ /* Validate User Input And Enable Or Disable Button */
    if (_signUpM.nodePassword.hasFocus){
      _signUpM.responsePass1 = instanceValidate.validatePassword(value);
      validateAllField();
      // Compare Password If Both Field Doesn't Empty 
      if (_signUpM.responsePass1 == null && _signUpM.responsePass2 != null) comparePassword();
    }     
    return _signUpM.responsePass1;
  }

  String validatePass2(String value) {
    if (_signUpM.nodeConfirmPassword.hasFocus){
      _signUpM.responsePass2 = instanceValidate.validatePassword(value);
      validateAllField();
    }
    return _signUpM.responsePass2;
  }

  void validateAllField(){

    // Check All Field Have No Error
    if ( _signUpM.responseInput == null &&  _signUpM.responsePass1 == null && _signUpM.responsePass2 == null ) {
      // Check All Field Is Not Empty
      if ( 
        (_signUpM.controlPhoneNums.text.isNotEmpty || _signUpM.controlEmails.text.isNotEmpty) &&
        _signUpM.controlConfirmPassword.text.isNotEmpty &&
        _signUpM.controlConfirmPassword.text.isNotEmpty
      ) {
        comparePassword();
      }
    }
    // Disable Button
    else {
      if (_signUpM.enable) setState(() => _signUpM.enable = false);
    }
  }

  void comparePassword(){
    if (_signUpM.controlConfirmPassword.text == _signUpM.controlPassword.text) { 
      _signUpM.responsePass2 = null;
      // Enable Button
      if (_signUpM.enable == false) setState(() => _signUpM.enable = true);
    } else {
      // Disable Button
      _signUpM.responsePass2 = "Password does not match";
      if (_signUpM.enable == true) setState(() => _signUpM.enable = false);
    }
  }

  // Show And Hide Passwords
  void showPassword(){
    Timer(
      Duration(milliseconds: 200), (){
        if (_signUpM.nodePassword.hasFocus) {
          setState(() {
            if (_signUpM.hidePassword1 == false) _signUpM.hidePassword1 = true;
            else _signUpM.hidePassword1 = false;
          });
        } else if (_signUpM.nodeConfirmPassword.hasFocus){
          setState(() {
            if (_signUpM.hidePassword2 == false) _signUpM.hidePassword2 = true;
            else _signUpM.hidePassword2 = false;
          });
        } 
      }
    );
  }

  void tabBarSelectChanged(int index) {
    if ( index == 1 ){
      _signUpM.controlPhoneNums.clear();
      _signUpM.nodePhoneNums.unfocus();
      setState(() { /* Disable Button */
        _signUpM.enable = false;
      });
      _signUpM.label = "email";
    } else {
      _signUpM.controlEmails.clear();
      _signUpM.nodeEmails.unfocus();
      setState(() { /* Disable Button */
        _signUpM.enable = false;
      });
      _signUpM.label = "phone";
    }
    setState(() {});
  }

  /* -------------- Submit --------------- */

  // Navigate To Fill User Info
  void submit() async { 

    // Display Dialog Loading
    dialogLoading(context);

    // Remove All Focus Field After Click Button
    clearFocusInput();

    try{
      // Post Register By Email
      if (_signUpM.label == "email") { 
        await registerByEmail();
      }
      // Post Register By Phone Number
      else { 
        await registerByPhoneNumber();
      }
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center), "Message");
    } catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center), "Message");
    }
  }

  // Register By Email
  Future<void> registerByEmail() async {

    await _postRequest.registerByEmail(_signUpM.controlEmails.text,  _signUpM.controlConfirmPassword.text).then((value) async {
      
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

    await _postRequest.registerByPhone(_signUpM.controlPhoneNums.text, _signUpM.controlConfirmPassword.text).then((value) async {
      _backend.response = value;
      if (_backend.response != null) {
        // Navigator.pop(context);
        _backend.mapData = json.decode(_backend.response.body);
        print("Register phone ${_backend.mapData}");
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
      // Only user register by phone number
      if (_backend.mapData['message'] == "Successfully registered!"){
        await dialog(
          context,
          textAlignCenter(text: "${_backend.mapData['message']}"),
          Icon(
            Icons.done_outline,
            color: hexaCodeToColor(AppColors.greenColor),
          ) 
        );

        await resendOtpCode();
      } else {
        await dialog(
          context,
          textAlignCenter(text: _backend.mapData['message']),
          Text("Message") 
        );
      }
    }
  }

  // Send Message After Register
  Future resendOtpCode() async {
    try {
      await _postRequest.resendCode(AppServices.removeZero(_signUpM.controlPhoneNums.text)).then((value) {
        _backend.mapData = json.decode(value.body);
        if(value.statusCode == 200){
          // Close Loading
          Navigator.pop(context); 
          Future.delayed(Duration(milliseconds: 100), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SmsCodeVerify(_signUpM.controlPhoneNums.text, _signUpM.controlConfirmPassword.text, _backend.mapData)
              )
            );
          });
        }
      });
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center), "Message");
    } catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center), "Message");
    }
  }

  Future<void> clearFocusInput() async {
    await Future.delayed(Duration(milliseconds: 100), (){
      FocusScope.of(context).unfocus();
    });
  }
  
  Widget build(BuildContext context) { /* User Sign Up Build */
    return Scaffold(
      key: _signUpM.globalKey,
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: BodyScaffold(
          child: SignUpBody(
            modelSignUp: _signUpM,
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

