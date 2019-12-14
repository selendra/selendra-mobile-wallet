/* Flutter Package */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
/* File Path */
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_first_screen/signup_first_body.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';

class SignUpFirst extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignUpFirstState();
  }
}

class SignUpFirstState extends State<SignUpFirst> {

  ModelSignUp _modelSignUp = ModelSignUp();

  /* Remove Current Screen */
  void popScreen() {
    Navigator.pop(context);
  }

  /* Validate User Inpput */
  submitValidator(Bloc bloc) async {
    checkConnection(context).then((isConnect) async {
      if ( isConnect == true ){
        validator(bloc);
      } else {
        setState(() {
          _modelSignUp.isProgress = false; 
          noInternet(context);
        });
      }
    });
  }

  /* Button Verify User Sign Up */
  validator(Bloc bloc) {
    /* Loading */
    dialogLoading(context);
    bloc.registerUser(context)
    .then((onValue){
      if (onValue == false) {
      } else if (onValue == true){
        Navigator.pushReplacementNamed(context, '/');
      }
    })
    .catchError((onError){
    });
  }
  
  resetBloc(Bloc bloc) {
    bloc.addUsersign(null);
  }

  void navigatePage() {
  }
  void onChanged(String valueChange) {
    _modelSignUp.phoneNumber = valueChange;
  }
  
  /* User Sign Up Widget */
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: scaffoldBGColor(color1, color2),
        child: Stack(
          children: <Widget>[
            paddingScreenWidget( /* Padding Whole Screen */
              context, 
              signUpFirstBodyWidget( /* Body Widget */
                context, 
                _modelSignUp, 
                popScreen, submitValidator, navigatePage, onChanged
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

