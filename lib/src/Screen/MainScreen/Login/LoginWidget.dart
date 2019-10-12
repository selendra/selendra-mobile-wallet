/* Flutter package */
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Screen/MainScreen/Login/LoginBodyWidget.dart';
import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
/* File path */
import '../../../Bloc/Bloc.dart';
import '../../../Provider/Check_Internet_Connection.dart';

class LoginWidget extends StatefulWidget {
  final Function setMyState;
  @override
  LoginWidget(this.setMyState);
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginWidget> {
  
  final String directory = "userID";

  bool isProgress = false, isLogedin = false;

  String token;

  /* User login Property*/
  final FocusNode firstNode = FocusNode();
  final FocusNode secondNode = FocusNode();
  TextEditingController controlEmails = TextEditingController();
  TextEditingController controlPasswords = TextEditingController();

  QueryResult queryResult = QueryResult();

  Bloc bloc = Bloc();

  @override
  initState() {
    /* Clear All Input Field */
    clearAllInput();
    /* Check For Previous Login */
    checkLoginBefore();
    /* Init State */
    super.initState();
  }

  /* Check For Previous Login */
  checkLoginBefore() async {
    var response = await fetchData('userToken');
    if (response != null){
      /* Loading */
      await Future.delayed(Duration(seconds: 2), () {
        dialogLoading(context);
      });
      /* Pop Loading */
      await Future.delayed(Duration(milliseconds: 800), () {
        Navigator.pop(context);
      });
      widget.setMyState();
      Navigator.pushReplacementNamed(context, '/homeScreen');
    }
  }

  /* Disable Login Button When Wrong Password And Error Something */
  void disableLoginButton(Bloc bloc) {
    bloc.addEmail(null); bloc.addPassword(null);
  }

  /* Clear Text In Field */
  void clearAllInput() async {
    controlEmails.clear(); controlPasswords.clear();
  }

  /* Check Internet Before Validate And FInish Validate It */
  void checkInputAndValidate() async {
    setState(() {isProgress = true;});  
    await Future.delayed(Duration(milliseconds: 100), (){
      checkConnection(context).then((isConnect) {
        if ( isConnect == true ) {
          validatorLogin(bloc, context, clearAllInput, disableLoginButton);
        } else {
          setState(() {
            isProgress = false;
            noInternet(context);
          });
        }
      }); 
    });
  }

  /* Validator User Login After Check Internet */
  void validatorLogin(Bloc bloc, BuildContext context, Function clearAllInput, Function disableLoginButton) async{
    /* Show Loading */
    dialogLoading(context);
    /* Response Result */
    final submitResponse = await bloc.submitMethod(context).then((data) async {
      if (data == true) {
        Navigator.pop(context);
        /* ReSet Bearer Token In Main Widget */
        widget.setMyState();
        /* Wait And Push Replace To HomePage */
        await Future.delayed(Duration(milliseconds: 300), () async {
          Navigator.pushReplacementNamed(context, '/homeScreen');
        });
      }
      return data;
    }).catchError((onError){
      Navigator.pop(context);
      setState(() => isProgress = false );
      return false;
    });
    if (submitResponse == false) {
      Navigator.pop(context);
      clearAllInput(); 
      disableLoginButton(bloc);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /* Body Widget */
          bodyWidget(bloc, context, controlEmails, controlPasswords, firstNode, secondNode, clearAllInput, disableLoginButton, validatorLogin),
        ],
      )
    );
  }

}
