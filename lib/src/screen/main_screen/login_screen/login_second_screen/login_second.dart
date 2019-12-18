import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_second_screen/login_second_body.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';

class LoginSecond extends StatefulWidget{

  final ModelLogin modelLogin;

  LoginSecond(this.modelLogin);
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
      FocusScope.of(context).requestFocus(widget.modelLogin.secondNode);
    });
  }
  
  void checkInputAndValidate() async { /* Check Internet Before Validate And Finish Validate*/
    setState(() {widget.modelLogin.isProgress = true;});  
    await Future.delayed(Duration(milliseconds: 100), (){
      checkConnection(context).then((isConnect) {
        if ( isConnect == true ) {
          validatorLogin(
            widget.modelLogin.bloc, context);
        } else {
          setState(() {
            widget.modelLogin.isProgress = false;
            noInternet(context);
          });
        }
      }); 
    });
  }

 
  void validatorLogin(Bloc bloc, BuildContext context) async{  /* Validator User Login After Check Internet */
    // dialogLoading(context); /* Show Loading */
    // bloc.submitMethod(context, widget.modelLogin);
    print(widget.modelLogin.controlEmails.text);
    print(widget.modelLogin.controlPasswords.text);
    // final submitResponse = await bloc.submitMethod(context, widget.modelLogin).then((data) async { /* Response Result */
    //   // if (data == true) {
    //   //   Navigator.pop(context);
    //   //   await Future.delayed(Duration(milliseconds: 200), () async { /* Wait And Push Replace To HomePage */
    //   //   });
    //   //   Navigator.pushReplacementNamed(context, '/dashboardScreen');
    //   // }
    //   // return data;
    // }).catchError((onError){
    //   Navigator.pop(context);
    //   setState(() => widget.modelLogin.isProgress = false );
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
          context, bothFieldBodyWidget(
            context,
            widget.modelLogin,
            onChanged,
            validatorLogin
          )
        ),
      ),
    );
  }
}

