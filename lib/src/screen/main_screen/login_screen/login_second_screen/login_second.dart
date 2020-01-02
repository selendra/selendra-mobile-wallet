import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_second_screen/login_second_body.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';

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
    super.initState();
    focusOnPassword();
  }

  focusOnPassword() async {
    await Future.delayed(Duration(milliseconds: 100), (){
      FocusScope.of(context).requestFocus(widget._modelLogin.nodePasswords);
    });
  }
  
  void checkInputAndValidate(Bloc bloc, BuildContext context) async { /* Check Internet Before Validate And Finish Validate*/
    // setState(() {widget._modelLogin.isProgress = true;});
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
        widget._modelLogin.controlPhoneNums.text,
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
    
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    // await Future.delayed(Duration(milliseconds: 100), (){
    //   checkConnection(context).then((isConnect) {
    //     if ( isConnect == true ) {
    //       validatorLogin(widget._modelLogin.bloc, context, label);
    //     } else {
    //       setState(() {
    //         widget._modelLogin.isProgress = false;
    //         noInternet(context);
    //       });
    //     }
    //   }); 
    // });
  }
 
  void validatorLogin(Bloc bloc, BuildContext context, String label) async{ /* Validator User Login After Check Internet */
    dialogLoading(context); /* Show Loading */
    // if (widget._modelLogin.label == "email") {
    //   await widget._modelLogin.bloc.submitMethod(
    //     context,
    //     widget._modelLogin.controlEmails.text,
    //     widget._modelLogin.controlPasswords.text,
    //     "registerbyemail", "email"
    //   );
    // } else {
    //   await widget._modelLogin.bloc.submitMethod(
    //     context,
    //     widget._modelLogin.controlPhoneNums.text,
    //     widget._modelLogin.controlPasswords.text,
    //     "registerbyphone", "phone"
    //   );
    // }
    // final submitResponse = await bloc.submitMethod(
    //     context,
    //     label == "Email" ? widget._modelLogin.controlEmails.text : widget._modelLogin.controlPhoneNums.text,
    //     widget._modelLogin.controlPasswords.text,
    //     "loginbyemail", "email" 
    //   ).then((data) async { /* Response Result */
    //   if (data == true) {
    //     Navigator.pop(context);
    //     await Future.delayed(Duration(milliseconds: 200), () async { /* Wait And Push Replace To HomePage */
    //     });
    //     Navigator.pushReplacementNamed(context, '/dashboardScreen');
    //   }
    // }).catchError((onError){
    //   Navigator.pop(context);
    //   setState(() => widget._modelLogin.isProgress = false );
    //   return false;
    // });
    // if (submitResponse == false) {
    //   Navigator.pop(context);
    //   // clearAllInput(); 
    //   // disableLoginButton(bloc);
    // }
  }

  void onChanged(String label, String valueChanged) {

  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: scaffoldBGColor(color1, color2),
        child: paddingScreenWidget(
          context, loginSdcondBodyWidget(
            context,
            widget._modelLogin,
            onChanged,
            checkInputAndValidate
          )
        ),
      ),
    );
  }
}

