import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelSignUp {

  final formState = GlobalKey<FormState>();
  final formStatePassword = GlobalKey<FormState>();
  final smsForm = GlobalKey<FormState>();
  final userInfoForm = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Bloc bloc = Bloc();
  
  bool enable = false;
  bool isProgress = false, isLogedin = false, isBoth = false, isMatch = true;
  bool hidePassword1 = true; bool hidePassword2 = true;

  String responseInput, responsePass1, responsePass2;
  String token, countryCode = "+855", label;
  String wallet;
  
  var colorSubmitted = Colors.transparent;

  Map<String, dynamic> dataSignUp;

  /* User login Properties */
  FocusNode nodeEmails = FocusNode();
  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodePassword = FocusNode();
  FocusNode nodeConfirmPassword = FocusNode();

  TextEditingController controlEmails = TextEditingController(); /* Value Controller Empty By Default */
  TextEditingController controlPhoneNums = TextEditingController();
  TextEditingController controlPassword = TextEditingController();
  TextEditingController controlConfirmPassword = TextEditingController();

  TabController tabController;

  /* Change PIN Properties */
  TextEditingController controlOldSecureNumber = TextEditingController();
  TextEditingController controlConfirmSecureNumber = TextEditingController();

  FocusNode nodeOldSecureNumber = FocusNode();
  FocusNode nodeConfirmSecureNumber = FocusNode();
}
