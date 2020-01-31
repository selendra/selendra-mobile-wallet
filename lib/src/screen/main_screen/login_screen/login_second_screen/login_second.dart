import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_second_screen/login_second_body.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';

class LoginSecond extends StatefulWidget{

  LoginSecond(this._modelLogin);
  
  final ModelLogin _modelLogin;

  @override
  State<StatefulWidget> createState() {
    return LoginSecondState();
  }
}

class LoginSecondState extends State<LoginSecond>{
  
  @override
  void initState() {
    focusOnPassword();
    super.initState();
  }

  focusOnPassword() async {
    await Future.delayed(Duration(milliseconds: 200), (){
      FocusScope.of(context).requestFocus(widget._modelLogin.nodePasswords);
    });
  }
  
  void checkInputAndValidate(BuildContext context) async { /* Check Internet Before Validate And Finish Validate*/
    if (widget._modelLogin.nodeEmails.hasFocus || widget._modelLogin.nodePhoneNums.hasFocus) {
      FocusScope.of(context).requestFocus(widget._modelLogin.nodePasswords);
    } else if (widget._modelLogin.enable2 == true) { /* Prevent Submit On Smart Keyboard */ /* Submit Login */
      dialogLoading(context); 
        var response;
        if (widget._modelLogin.label == "email") {
          response = await widget._modelLogin.bloc.loginMethod(
            context,
            widget._modelLogin.controlEmails.text,
            widget._modelLogin.controlPasswords.text,
            "/loginbyemail", "email"
          );
        } else {
          response = await widget._modelLogin.bloc.loginMethod(
            context,
            "${widget._modelLogin.countryCode}${widget._modelLogin.controlPhoneNums.text}",
            widget._modelLogin.controlPasswords.text,
            "/loginbyphone", "phone"
          );
        }
        if (response == true) {
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (context) => Dashboard()), 
            ModalRoute.withName('/')
          );
        }
    }
  }

  void onChanged(String label, String valueChanged) {
    widget._modelLogin.formState2.currentState.validate(); /* Trigger Global Key To Call Function Validate */
  }

  String validateInput(String value){ /* Initial Validate */
    if (widget._modelLogin.label == "email"){
      if (widget._modelLogin.nodeEmails.hasFocus) { /* If Email Field Has Focus */
        widget._modelLogin.responseEmailPhone = instanceValidate.validateEmails(value);
        if (widget._modelLogin.responseEmailPhone == null && widget._modelLogin.responsePassword == null ) enableButton();
        else if ( widget._modelLogin.enable2 == true ) setState(() => widget._modelLogin.enable2 = false);
      }
    } else {
      if (widget._modelLogin.nodePhoneNums.hasFocus) { /* If Phone Number Field Has Focus */
        widget._modelLogin.responseEmailPhone = instanceValidate.validatePhone(value);
        if (widget._modelLogin.responseEmailPhone == null && widget._modelLogin.responsePassword == null ) enableButton();
        else if ( widget._modelLogin.enable2 == true ) setState(() => widget._modelLogin.enable2 = false);
      }
    }
    return widget._modelLogin.responseEmailPhone;
  }
  
  String validatePassword(String value){ /* Validate User Password Input */
    if (widget._modelLogin.nodePasswords.hasFocus) {
      widget._modelLogin.responsePassword = instanceValidate.validatePassword(value);
      if (widget._modelLogin.responseEmailPhone == null && widget._modelLogin.responsePassword == null ) enableButton();
      else if ( widget._modelLogin.enable2 == true ) setState(() => widget._modelLogin.enable2 = false);
    }
    return widget._modelLogin.responsePassword;
  }

  void enableButton() { /* Validate Button */
    if ( widget._modelLogin.label == 'email'){
      if (widget._modelLogin.controlEmails.text != '' && widget._modelLogin.controlPasswords.text != '' ) setState(() => widget._modelLogin.enable2 = true);
    } else {
      if (widget._modelLogin.controlPhoneNums.text != '' && widget._modelLogin.controlPasswords.text != '' ) setState(() => widget._modelLogin.enable2 = true);
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: paddingScreenWidget(
        context, 
        loginSecondBodyWidget(
          context,
          widget._modelLogin,
          validateInput, validatePassword,
          onChanged,
          checkInputAndValidate
        )
      ),
    );
  }
}

