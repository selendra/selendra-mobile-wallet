/* Flutter Package */
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/* File Path */
import 'package:Wallet_Apps/src/Screen/MainScreen/SignUp/SignUpBodyWidget.dart';
import '../../../Bloc/Bloc.dart';
import '../../../Provider/Reuse_Widget.dart';
import '../../../Provider/Check_Internet_Connection.dart';

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
      backgroundColor: Color(convertHexaColor(backgroundColor)),
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

