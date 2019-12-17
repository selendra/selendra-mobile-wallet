import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelSignUp {
  String directory = "userID";

  bool isProgress = false, isLogedin = false, isBoth = false;

  String token, phoneNumber = "", countryCode = "+855 ", gender;

  var colorSubmitted = Colors.transparent;

  Bloc bloc = Bloc();
  
  /* User login Property*/
  FocusNode nodeEmails = FocusNode();
  FocusNode nodePassword = FocusNode();
  FocusNode nodeConfirmPasswords = FocusNode();
  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodeSmsCode = FocusNode();
  FocusNode nodeFirstName = FocusNode();
  FocusNode nodeMidName = FocusNode();
  FocusNode nodeLastName = FocusNode();

  TextEditingController controlEmails = TextEditingController();
  TextEditingController controlPasswords = TextEditingController();
  TextEditingController controlSmsCode = TextEditingController();
  TextEditingController controlConfirmPasswords = TextEditingController();
  TextEditingController controlPhoneNums = TextEditingController();
  TextEditingController controlFirstName = TextEditingController();
  TextEditingController controlMidName = TextEditingController();
  TextEditingController controlLastName = TextEditingController();

  // QueryResult queryResult = QueryResult();

}