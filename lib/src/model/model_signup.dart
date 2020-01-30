import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelSignUp {

  final formStateEmailPhone = GlobalKey<FormState>();
  final formStatePassword = GlobalKey<FormState>();
  final smsForm = GlobalKey<FormState>();
  final userInfoForm = GlobalKey<FormState>();
  
  bool enable1 = false;
  bool enable2 = false;

  String responsePass1, responsePass2;
  var response;

  Bloc bloc = Bloc();

  String wallet;

  bool isProgress = false, isLogedin = false, isBoth = false, isMatch = true;

  String token, countryCode = "+855", gender, label, genderLabel = "Gender";

  var colorSubmitted = Colors.transparent;

  /* User login Properties */
  FocusNode nodeEmails = FocusNode();
  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodePassword = FocusNode();
  FocusNode nodeConfirmPassword = FocusNode();

  TextEditingController controlEmails = TextEditingController(); /* Value Controller Empty By Default */
  TextEditingController controlPhoneNums = TextEditingController();
  TextEditingController controlPassword = TextEditingController();
  TextEditingController controlConfirmPassword = TextEditingController();

  FocusNode nodeSmsCode = FocusNode();
  FocusNode nodeFirstName = FocusNode();
  FocusNode nodeMidName = FocusNode();
  FocusNode nodeLastName = FocusNode();
  FocusNode nodeResetCode = FocusNode();

  TextEditingController controlSmsCode = TextEditingController();
  TextEditingController controlFirstName = TextEditingController();
  TextEditingController controlMidName = TextEditingController();
  TextEditingController controlLastName = TextEditingController();
  TextEditingController controlResetCode = TextEditingController();

  TabController tabController;

  /* Change PIN Properties */
  TextEditingController controlOldSecureNumber = TextEditingController();
  TextEditingController controlConfirmSecureNumber = TextEditingController();

  FocusNode nodeOldSecureNumber = FocusNode();
  FocusNode nodeConfirmSecureNumber = FocusNode();
}
