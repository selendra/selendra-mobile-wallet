import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_second_screen/login_second.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first_body.dart';
import '../../../../bloc/bloc.dart';


class LoginFirstScreen extends StatefulWidget {
  LoginFirstScreen();
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

  void onChanged(String label, String valueChange) {
    if (label == "Email") _modelLogin.label = "email";
    else _modelLogin.label = "phone_number";
  }

  void tabBarSelectChanged(int index) {
    if ( index == 0 ) _modelLogin.label = "email";
    else _modelLogin.label = "phone_number";
    setState(() {});
  }

  void navigatePage(BuildContext context) async {
    // if (!(_modelLogin.phoneNumber.length < 7) && _modelLogin.phoneNumber != "") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSecond(_modelLogin)));
    // }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: scaffoldBGColor("#344051", "#222834"),
          child: Stack(
            children: <Widget>[
              paddingScreenWidget( /* Body Widget */
                context, 
                loginFirstBodyWidget(
                  context,
                  _modelLogin,
                  onChanged, tabBarSelectChanged,
                  navigatePage
                )
              ), 
            ],
          ),
        )
      ),
    );
  }
}
