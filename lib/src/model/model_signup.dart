import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelSignUp {

  final formStateEmailPhone = GlobalKey<FormState>();
  final formStatePassword = GlobalKey<FormState>();
  final smsForm = GlobalKey<FormState>();
  final userInfoForm = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Bloc bloc = Bloc();
  
  bool enable1 = false;
  bool enable2 = false;
  bool isProgress = false, isLogedin = false, isBoth = false, isNotMatch = false;
  bool showPassword1 = false; bool showPassword2 = false;

  String responsePass1, responsePass2;
  String token, countryCode = "+855", label;
  String wallet;

  var response;
  
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

  FocusNode nodeResetCode = FocusNode();

  /* Account Confirmation */
  String code = "";
  FocusNode nodeSmsCode = FocusNode();
  TextEditingController controlSmsCode = TextEditingController();
  TextEditingController controlResetCode = TextEditingController();

  TabController tabController;

  /* Change PIN Properties */
  TextEditingController controlOldSecureNumber = TextEditingController();
  TextEditingController controlConfirmSecureNumber = TextEditingController();

  FocusNode nodeOldSecureNumber = FocusNode();
  FocusNode nodeConfirmSecureNumber = FocusNode();
}
