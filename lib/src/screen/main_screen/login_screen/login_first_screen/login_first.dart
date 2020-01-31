import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_second_screen/login_second.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first_body.dart';
import '../../../../bloc/bloc.dart';


class LoginFirstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFirstState();
  } 
}

class LoginFirstState extends State<LoginFirstScreen> {

  ModelLogin _modelLogin = ModelLogin();

  @override
  initState() {
    clearAllInput(); /* Clear All Input Field */
    super.initState(); /* Init State */
  }
  
  void disableLoginButton(Bloc bloc) { /* Disable Login Button When Wrong Password And Error Something */
    bloc.addEmail(null); bloc.addPassword(null);
  }

  void clearAllInput() async { /* Clear Text In Field */
    _modelLogin.controlEmails.clear(); _modelLogin.controlPasswords.clear();
  }

  void onChanged(String label, String valueChange) { /* Change Value */
    _modelLogin.formState1.currentState.validate(); /* Trigger Global Key To Call Function Validate */
    if (label == "Email") _modelLogin.label = "email"; /* Set Label */
    else _modelLogin.label = "phone"; /* Set Label */
  }

  String validateInput(String value){ /* Initial Validate */
    if (_modelLogin.label == "email"){
      _modelLogin.responseEmailPhone = validateInstance.validateEmails(value);
      setState(() {
        if (_modelLogin.responseEmailPhone == null) _modelLogin.enable1 = true; 
        else _modelLogin.enable1 = false;
      });
    } else {
      _modelLogin.responseEmailPhone = validateInstance.validatePhone(value);
      setState(() {
        if (_modelLogin.responseEmailPhone == null) _modelLogin.enable1 = true; 
        else _modelLogin.enable1 = false;
      });
    }
    return _modelLogin.responseEmailPhone;
  }

  void tabBarSelectChanged(int index) { /* Tab Bar Select Change Label */ 
    if ( index == 0 ){ /* Tab On Email */
      _modelLogin.controlPhoneNums.clear(); /* Clear Data Phone Number Field */
      _modelLogin.nodePhoneNums.unfocus();
      setState(() {
        _modelLogin.enable1 = false;
      });
      _modelLogin.label = "email";
    } else {
      _modelLogin.controlEmails.clear();
      _modelLogin.nodeEmails.unfocus();
      setState(() {
        _modelLogin.enable1 = false;
      });
      _modelLogin.label = "phone";
    }
    setState(() {});
  }

  void navigatePage(BuildContext context) async {
    if (_modelLogin.enable1 == true){ /* Prevent Submit On Smart Keyboard */ 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSecond(_modelLogin)));
    }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        body: paddingScreenWidget( /* Body Widget */
          context,
          loginFirstBodyWidget(
            context,
            _modelLogin,
            validateInput, onChanged, tabBarSelectChanged, navigatePage
          )
        )
      ),
    );
  }
}
