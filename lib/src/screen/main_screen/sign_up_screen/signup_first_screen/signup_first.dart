/* Flutter Package */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/create_password_screen/create_password.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_first_screen/signup_first_body.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';

class SignUpFirst extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignUpFirstState();
  }
}

class SignUpFirstState extends State<SignUpFirst> with SingleTickerProviderStateMixin{

  ModelSignUp _modelSignUp = ModelSignUp();

  @override
  void initState() {
    super.initState();
    _modelSignUp.tabController = new TabController(length: 2, vsync: this); /* Initialize Variable TabController */
  }

  void popScreen() { /* Pop Current Screen */
    Navigator.pop(context);
  }

  void resetBloc(Bloc bloc) { /* Reset All Field */
    bloc.addUsersign(null);
  }

  void navigatePage(BuildContext context) { /* Navigate To Second Sign Up */
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePassword(_modelSignUp)));
  }

  void onChanged(String label, String onchanged) { /* Input Field Value Change */
    _modelSignUp.formStateEmailPhone.currentState.validate();
    if (label == "Email") _modelSignUp.label = "email";
    else _modelSignUp.label = "phone";
  }

  String validateInput(String value){ /* Initial Validate */
    if (_modelSignUp.label == "email"){
      _modelSignUp.response = validateInstance.validateEmails(value);
      setState(() {
        if (_modelSignUp.response == null) _modelSignUp.enable1 = true; 
        else _modelSignUp.enable1 = false;
      });
    } else {
      _modelSignUp.response = validateInstance.validatePhone(value);
      setState(() {
        if (_modelSignUp.response == null) _modelSignUp.enable1 = true; 
        else _modelSignUp.enable1 = false;
      });
    }
    return _modelSignUp.response;
  }

  void tabBarSelectChanged(int index) {
    if ( index == 0 ){
      _modelSignUp.controlPhoneNums.clear();
      _modelSignUp.nodePhoneNums.unfocus();
      setState(() { /* Disable Button */
        _modelSignUp.enable1 = false;
      });
      _modelSignUp.label = "email";
    } else {
      _modelSignUp.controlEmails.clear();
      _modelSignUp.nodeEmails.unfocus();
      setState(() { /* Disable Button */
        _modelSignUp.enable1 = false;
      });
      _modelSignUp.label = "phone";
    }
    setState(() {});
  }
  
  Widget build(BuildContext context) { /* User Sign Up Build Widget */
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        body: paddingScreenWidget( /* Padding Whole Screen */
          context, 
          signUpFirstBodyWidget( /* Body Widget */
            context, 
            _modelSignUp, 
            validateInput, onChanged, popScreen, navigatePage, tabBarSelectChanged, 
          )
        )
      ),
    );
  }

}

