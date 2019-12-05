/* Flutter Package */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/* File Path */
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/sign_up_body.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import '../../../provider/reuse_widget.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';

class SignUpWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUpWidget> {

  bool isProgress = false;
  final bloc = Bloc();

  /* Email and Password Node Focus */
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  /* Email and Password Editor */
  TextEditingController emailEditor = TextEditingController();
  TextEditingController passwordEditor = TextEditingController();

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
          isProgress = false; 
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
  
  /* User Sign Up Widget */
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          bodyWidget(context, bloc, popScreen, submitValidator, emailNode, passwordNode, emailEditor, passwordEditor),
        ],
      ),
    );
    
  }

}

