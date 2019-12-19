import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_second_screen/signup_second_body.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';

class SignUpSecond extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  SignUpSecond(this._modelSignUp);
  @override
  State<StatefulWidget> createState() {
    return SignUpSecondState();
  }
}

class SignUpSecondState extends State<SignUpSecond>{

  @override
  void initState() {
    super.initState();
    focusOnPassword();
  }

  focusOnPassword() async {
    await Future.delayed(Duration(milliseconds: 100), (){
      FocusScope.of(context).requestFocus(widget._modelSignUp.nodeSmsCode);
    });
  }

  /* Check Internet Before Validate And Finish Validate*/
  void checkInputAndValidate() async {
    setState(() {widget._modelSignUp.isProgress = true;});  
    await Future.delayed(Duration(milliseconds: 100), (){
      checkConnection(context).then((isConnect) {
        if ( isConnect == true ) {
          validatorLogin(
            widget._modelSignUp.bloc, context);
        } else {
          setState(() {
            widget._modelSignUp.isProgress = false;
            noInternet(context);
          });
        }
      }); 
    });
  }

  void validatorLogin(Bloc bloc, BuildContext context) async{  /* Validator User Login After Check Internet */
    // dialogLoading(context); /* Pop Up Loading */
    // final submitResponse = await bloc.submitMethod(context, widget._modelSignUp).then((data) async { /* Response Result */
    //   if (data == true) {
    //     Navigator.pop(context); /* Close Loading Dialog */
    //     await Future.delayed(Duration(milliseconds: 200), () async { /* Wait And Push Replace To HomePage */
    //     });
    //     Navigator.pushReplacementNamed(context, '/dashboardScreen');
    //   }
    //   return data;
    // }).catchError((onError){
    //   Navigator.pop(context);
    //   setState(() => widget._modelSignUp.isProgress = false );
    //   return false;
    // });
    // if (submitResponse == false) {
    //   Navigator.pop(context);
    //   // clearAllInput(); 
    //   // disableLoginButton(bloc);
    // }
  }

  void onChanged(String valueChanged) {

  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: scaffoldBGColor(color1, color2),
        child: paddingScreenWidget(
          context, 
          signUpSecondBodyWidget(context, widget._modelSignUp, onChanged, validatorLogin)
        ),
      ),
    );
  }
}

