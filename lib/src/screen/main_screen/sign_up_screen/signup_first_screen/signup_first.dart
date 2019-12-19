/* Flutter Package */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_first_screen/signup_first_body.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_second_screen/signup_second.dart';

class SignUpFirst extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignUpFirstState();
  }
}

class SignUpFirstState extends State<SignUpFirst> {

  ModelSignUp _modelSignUp = ModelSignUp();

  void popScreen() { /* Pop Current Screen */
    Navigator.pop(context);
  }
  
  void submitValidator(Bloc bloc) async { /* Validate User Inpput */
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

  
  void validator(Bloc bloc) { /* Button Verify User Sign Up */
    dialogLoading(context); /* Loading */
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
  
  void resetBloc(Bloc bloc) { /* Reset All Field */
    bloc.addUsersign(null);
  }

  void navigatePage() { /* Navigate To Second Sign Up */
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpSecond(_modelSignUp)));
  }

  void onChanged(String valueChange) { /* Input Field Value Change */
    _modelSignUp.phoneNumber = valueChange;
  }
  
  Widget build(BuildContext context) { /* User Sign Up Build Widget */
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
            ],
          ),
        )
      ),
    );
  }

}
