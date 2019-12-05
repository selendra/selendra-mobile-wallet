import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/both_field_screen/both_field_body.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/model_login.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_reuse_widget.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';

class BothFieldScreen extends StatefulWidget{

  final ModelLogin modelLogin;
  // final Function setMyState;

  BothFieldScreen(this.modelLogin);
  @override
  State<StatefulWidget> createState() {
    return BothFieldState();
  }
}

class BothFieldState extends State<BothFieldScreen>{

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

  /* Check Internet Before Validate And Finish Validate*/
  void checkInputAndValidate() async {
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

  /* Validator User Login After Check Internet */
  void validatorLogin(Bloc bloc, BuildContext context) async{
    /* Show Loading */
    dialogLoading(context);
    /* Response Result */
    final submitResponse = await bloc.submitMethod(context).then((data) async {
      if (data == true) {
        Navigator.pop(context);
        /* Wait And Push Replace To HomePage */
        await Future.delayed(Duration(milliseconds: 200), () async {
          Navigator.pushReplacementNamed(context, '/dashboardScreen');
        });
      }
      return data;
    }).catchError((onError){
      Navigator.pop(context);
      setState(() => widget.modelLogin.isProgress = false );
      return false;
    });
    if (submitResponse == false) {
      Navigator.pop(context);
      // clearAllInput(); 
      // disableLoginButton(bloc);
    }
  }

  void onChanged(String valueChanged) {

  }

  Widget build(BuildContext context){
    return Scaffold(
      body: paddingScreenWidget(
        context, bothFieldBodyWidget(
          context,
          widget.modelLogin,
          onChanged,
          validatorLogin
        )
      ),
    );
  }
}

