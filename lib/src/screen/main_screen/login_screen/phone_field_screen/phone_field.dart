import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/both_field_screen/both_field.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/phone_field_screen/phone_field_body.dart';
import '../../../../bloc/bloc.dart';


class PhoneFieldScreen extends StatefulWidget {
  final Function setMyState;
  PhoneFieldScreen(this.setMyState);
  @override
  State<StatefulWidget> createState() {
    return PhoneFieldScreenState();
  } 
}

class PhoneFieldScreenState extends State<PhoneFieldScreen> {

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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BothFieldScreen(modelLogin, widget.setMyState)));
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
              phoneFieldBodyWidget(
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
