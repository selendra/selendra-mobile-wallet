import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_second_screen/login_second.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first_body.dart';
import '../../../../bloc/bloc.dart';


class LoginFirstScreen extends StatefulWidget {
  final setMyState;
  LoginFirstScreen(this.setMyState);
  @override
  State<StatefulWidget> createState() {
    return LoginFirstState();
  } 
}

class LoginFirstState extends State<LoginFirstScreen> {

  ModelLogin modelLogin = ModelLogin();

  @override
  initState() {
    /* Clear All Input Field */
    clearAllInput();
    /* Init State */
    super.initState();
  }
  /* Disable Login Button When Wrong Password And Error Something */
  void disableLoginButton(Bloc bloc) {
    bloc.addEmail(null); bloc.addPassword(null);
  }

  /* Clear Text In Field */
  void clearAllInput() async {
    modelLogin.controlEmails.clear(); modelLogin.controlPasswords.clear();
  }

  void onChanged(String valueChange) {
    modelLogin.phoneNumber = valueChange;
  }

  void navigatePage(BuildContext context) {
    if (!(modelLogin.phoneNumber.length < 7) && modelLogin.phoneNumber != "") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSecond(modelLogin, widget.setMyState)));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: scaffoldBGColor("#344051", "#222834"),
        child: Stack(
          children: <Widget>[
            /* Body Widget */
            paddingScreenWidget(
              context, 
              loginFirstBodyWidget(
                context,
                modelLogin,
                onChanged,
                navigatePage
              )
            )
            // loginBodyWidget(
            //   isBoth,
            //   phoneNumber,
            //   bloc,
            //   context,
            //   controlEmails, controlPasswords,
            //   firstNode, secondNode,
            //   clearAllInput,
            //   disableLoginButton,
            //   validatorLogin,
            //   navigatePage,
            //   colorSubmitted,
            // ),
          ],
        ),
      )
    );
  }

}
