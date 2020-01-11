import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelSignUp {
  String directory = "userID";

  bool isProgress = false, isLogedin = false, isBoth = false, isMatch = true;

  String token, countryCode = "+855", gender, label, genderLabel = "Gender";

  var colorSubmitted = Colors.transparent;

  Bloc bloc = Bloc();

  /* User login Properties */
  FocusNode nodeEmails = FocusNode();
  FocusNode nodeSecureNumber = FocusNode();
  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodeSmsCode = FocusNode();
  FocusNode nodeFirstName = FocusNode();
  FocusNode nodeMidName = FocusNode();
  FocusNode nodeLastName = FocusNode();
  FocusNode nodeResetCode = FocusNode();

  TextEditingController controlEmails =
      TextEditingController(); /* Value Controller Empty By Default */
  TextEditingController controlSecureNumber = TextEditingController();
  TextEditingController controlSmsCode = TextEditingController();
  TextEditingController controlPhoneNums = TextEditingController();
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
